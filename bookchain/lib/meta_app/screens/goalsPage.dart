import 'package:flutter/material.dart';
import 'createNewGoal.dart';
import 'homePage.dart';

class GoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals'),
        automaticallyImplyLeading: false, // Prevents the back arrow buttons
      ),
      body: Center(
        child: Text(
          'Goals Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
