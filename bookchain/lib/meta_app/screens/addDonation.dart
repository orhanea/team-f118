import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDonationPage extends StatefulWidget {
  @override
  _AddDonationPageState createState() => _AddDonationPageState();
}

class _AddDonationPageState extends State<AddDonationPage> {
  List<String> provinces = [];
  late String selectedProvince = '';
  Map<String, List<String>> districts = {};
  late String selectedDistrict = '';

  @override
  void initState() {
    super.initState();
    loadProvinces();
  }

  Future<void> loadProvinces() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('provinces').get();

    setState(() {
      provinces = querySnapshot.docs.map((doc) => doc.id).toList();
      selectedProvince = provinces[0];
      districts = {};
      selectedDistrict = '';
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
      selectedDistrict = districtList[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Donation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
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
              items: provinces.map<DropdownMenuItem<String>>((String province) {
                return DropdownMenuItem<String>(
                  value: province,
                  child: Text(province),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
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
              items: districts[selectedProvince]!
                  .map<DropdownMenuItem<String>>((String district) {
                return DropdownMenuItem<String>(
                  value: district,
                  child: Text(district),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add donation logic here
              },
              child: Text('Add Donation'),
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
