import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDonationsPage extends StatefulWidget {
  @override
  _UserDonationsPageState createState() => _UserDonationsPageState();
}

class _UserDonationsPageState extends State<UserDonationsPage> {
  late User? currentUser;
  late Stream<QuerySnapshot<Map<String, dynamic>>> donationsStream;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    loadDonations();
  }

  void loadDonations() {
    final String currentUserUid = currentUser!.uid;
    donationsStream = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserUid)
        .collection('donations')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Donations'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: donationsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text('No donations found.'),
            );
          }

          final donations = snapshot.data!.docs;

          if (donations.isEmpty) {
            return Center(
              child: Text('No donations found.'),
            );
          }

          return ListView.builder(
            itemCount: donations.length,
            itemBuilder: (context, index) {
              final donationData = donations[index].data();
              final donationTimestamp =
                  donationData['donationTimestamp'] as Timestamp;

              return Card(
                child: ListTile(
                  title: Text('District: ${donationData['district']}'),
                  subtitle: Text('Status: ${donationData['donationStatus']}'),
                  trailing: Text(
                    'Date: ${donationTimestamp.toDate().toString()}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
