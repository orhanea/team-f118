import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProvinceDistrictPage extends StatefulWidget {
  const AddProvinceDistrictPage({Key? key}) : super(key: key);

  @override
  State<AddProvinceDistrictPage> createState() =>
      _AddProvinceDistrictPageState();
}

class _AddProvinceDistrictPageState extends State<AddProvinceDistrictPage> {
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  void addProvinceDistrict() async {
    final String province = provinceController.text;
    final String district = districtController.text;

    if (province.isNotEmpty && district.isNotEmpty) {
      final CollectionReference provincesCollection =
          FirebaseFirestore.instance.collection('provinces');
      final DocumentReference provinceDocRef =
          provincesCollection.doc(province);

      // Create the province document if it doesn't exist
      if (!(await provinceDocRef.get()).exists) {
        await provinceDocRef.set(<String, dynamic>{});
      }

      // Add the district to the nested "districts" collection
      final CollectionReference districtsCollection =
          provinceDocRef.collection('districts');
      await districtsCollection.add({
        'district': district,
        'totalDonations': 0,
      });

      // Clear the text fields after adding the data
      provinceController.clear();
      districtController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Province and District'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: provinceController,
              decoration: InputDecoration(
                labelText: 'Province',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: districtController,
              decoration: InputDecoration(
                labelText: 'District',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: addProvinceDistrict,
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
