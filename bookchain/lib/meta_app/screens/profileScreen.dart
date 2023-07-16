import 'package:bookchain/meta_app/screens/donationsPage.dart';
import 'package:bookchain/meta_app/screens/myAccount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookchain/meta_app/helpers/constants/colors.dart';
import 'package:bookchain/meta_app/components/profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookchain/meta_app/screens/myAccount.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username;
  String? email;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch the user details from Firestore and retrieve the username and email.
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();
        // Check if the data exists or not.
        if (snapshot.exists) {
          setState(() {
            username = snapshot.data()?['username'];
            email = snapshot.data()?['email'];
          });
        }
      }
    } catch (error) {
      // Handle any errors that occur during fetching the user details.
      print('Error fetching user details: $error');
    }
  }

  void _navigateToEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => const EditProfilePage()),
    );
  }

  void _navigateToMyDonations() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => UserDonationsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        ColorSpecs.colorInstance.kPrimaryColor.withOpacity(.5),
                    width: 5.0,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: ExactAssetImage('assets/images/profile.png'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: size.width * .3,
                child: Row(
                  children: [
                    Text(
                      username ?? 'Loading...',
                      style: TextStyle(
                        color: ColorSpecs.colorInstance.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      child: Image.asset("assets/images/verified.png"),
                    ),
                  ],
                ),
              ),
              Text(
                email ?? 'Loading...',
                style: TextStyle(
                  color: ColorSpecs.colorInstance.black.withOpacity(.3),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _navigateToEditProfile, // Add onTap callback
                      child: const ProfileWidget(
                        icon: Icons.person,
                        title: 'My Profile',
                      ),
                    ),
                    const ProfileWidget(
                      icon: Icons.notifications,
                      title: 'Notifications',
                    ),
                    GestureDetector(
                      onTap: _navigateToMyDonations, // Add onTap callback
                      child: const ProfileWidget(
                        icon: Icons.card_giftcard_rounded,
                        title: 'Donations',
                      ),
                    ),
                    const ProfileWidget(
                      icon: Icons.logout,
                      title: 'Log Out',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
