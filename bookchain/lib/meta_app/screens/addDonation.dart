import 'package:bookchain/meta_app/screens/chainPage.dart';
import 'package:bookchain/meta_app/screens/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookchain/meta_app/components/loadingScreen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/constants/textStyles.dart';

class AddDonationPage extends StatefulWidget {
  @override
  _AddDonationPageState createState() => _AddDonationPageState();
}

class _AddDonationPageState extends State<AddDonationPage> {
  List<String> provinces = [];
  late String selectedProvince = '';
  Map<String, List<String>> districts = {};
  late String selectedDistrict = '';
  bool loading = false;

  final TextEditingController provinceController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Create a global form key
  late User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    loadProvinces();
  }

  Future<void> loadProvinces() async {
    setState(() {
      loading = true;
    });

    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('provinces').get();

    setState(() {
      provinces = querySnapshot.docs.map((doc) => doc.id).toList();
      selectedProvince = provinces[0];
      districts = {};
      selectedDistrict = '';
      loading = false;
    });
    loadDistricts(selectedProvince);
  }

  Future<void> loadDistricts(String province) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('provinces')
        .doc(province)
        .collection('districts')
        .get();

    final List<String> districtList =
        querySnapshot.docs.map((doc) => doc['district'] as String).toList();

    setState(() {
      districts = {
        province: districtList,
      };
      selectedDistrict = districtList.isNotEmpty ? districtList[0] : '';
    });
  }

  void addDonationCount(DocumentReference userDocRef) {
    userDocRef.update({
      'totalDonations': FieldValue.increment(1),
    }).then((_) {
//successful addition
    }).catchError((error) {});
  }

  void createDonation() {
    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserUid);

    // Create a map to represent the donation data
    final Map<String, dynamic> donationData = {
      'district': selectedDistrict,
      'province': selectedProvince,
      'donationStatus': "Pending",
      'donationTimestamp': FieldValue.serverTimestamp(),
    };

    final Map<String, dynamic> userData = {
      'userID': currentUserUid,
      'donationStatus': "Pending",
      'donationTimestamp': FieldValue.serverTimestamp(),
    };

    final districtDocRef = FirebaseFirestore.instance
        .collection('provinces')
        .doc(selectedProvince)
        .collection('districts')
        .doc(selectedDistrict);

    final donationsCollection = userDocRef.collection('donations');
    final userCollection = districtDocRef.collection('users');

    userCollection.add(userData).then((value) {
      // User data added successfully

      // Now, add the donation data
      donationsCollection.add(donationData).then((value) {
        // Donation created successfully
        addDonationCount(userDocRef);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChainPage()),
        );
      }).catchError((error) {
        // An error occurred while creating the donation
        // Handle the error accordingly
      });
    }).catchError((error) {
      // An error occurred while adding user data
      // Handle the error accordingly
    });
  }

  @override
  void dispose() {
    provinceController.dispose();
    districtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Add Donation',
                style: TextStyles.styleInstance.title2,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Select Province:',
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: selectedProvince,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedProvince = newValue!;
                        loadDistricts(selectedProvince);
                      });
                    },
                    items: provinces
                        .map<DropdownMenuItem<String>>((String province) {
                      return DropdownMenuItem<String>(
                        value: province,
                        child: Text(province),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'Select District:',
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: selectedDistrict,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDistrict = newValue!;
                      });
                    },
                    items: districts[selectedProvince] != null
                        ? districts[selectedProvince]!
                            .map<DropdownMenuItem<String>>((String district) {
                            return DropdownMenuItem<String>(
                              value: district,
                              child: Text(district),
                            );
                          }).toList()
                        : [],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      createDonation();
                    },
                    child: Text('Add Donation',
                        style: TextStyle(color: Colors.blueGrey)),
                  ),
                ],
              ),
            ),
          );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('selectedProvince', selectedProvince));
  }
}
