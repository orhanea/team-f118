import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddDonationPage extends StatefulWidget {
  @override
  _AddDonationPageState createState() => _AddDonationPageState();
}

class _AddDonationPageState extends State<AddDonationPage> {
  late String selectedProvince = provinces[0];
  late String selectedDistrict = districts[selectedProvince]![0];

  List<String> provinces = ['Province 1', 'Province 2', 'Province 3'];
  Map<String, List<String>> districts = {
    'Province 1': ['District A', 'District B', 'District C'],
    'Province 2': ['District D', 'District E', 'District F'],
    'Province 3': ['District G', 'District H', 'District I'],
  };

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
                  selectedDistrict = "";
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
              items: selectedProvince == null
                  ? null
                  : districts[selectedProvince]
                      ?.map<DropdownMenuItem<String>>((String district) {
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
