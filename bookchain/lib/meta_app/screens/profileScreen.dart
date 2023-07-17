import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookchain/meta_app/screens/donationsPage.dart';
import 'package:bookchain/meta_app/screens/loginScreen.dart';
import 'package:bookchain/meta_app/screens/myAccount.dart';
import 'package:bookchain/meta_app/screens/chainPage.dart';
import 'package:bookchain/meta_app/screens/notificationPage.dart';
import 'package:bookchain/meta_app/helpers/constants/colors.dart';
import 'package:bookchain/meta_app/components/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String? username;
  String? email;
  String? avatarUrl;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (snapshot.exists) {
          setState(() {
            username = snapshot.data()?['username'];
            email = snapshot.data()?['email'];
          });
        }

        DocumentSnapshot<Map<String, dynamic>> avatarSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('pics').doc('avatar').get();

        if (avatarSnapshot.exists) {
          setState(() {
            avatarUrl = avatarSnapshot.data()?['avatarUrl'];
          });
        }
      }
    } catch (error) {
      print('Error fetching user details: $error');
    }
  }

  void _navigateToChainPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => ChainPage()),
    );
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

  void _logout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()),
    );
  }

  void _navigateToNotification() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => NotificationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
              _navigateToChainPage();
          },
        ),
      ),
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
                    color: ColorSpecs.colorInstance.kPrimaryColor.withOpacity(.5),
                    width: 5.0,
                  ),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: avatarUrl != null
                      ? NetworkImage(avatarUrl!)
                      : const AssetImage('assets/images/profile.png') as ImageProvider,
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
                    GestureDetector(
                      onTap: _navigateToNotification, // Add onTap callback
                      child: const ProfileWidget(
                        icon: Icons.notifications,
                        title: 'Notifications',
                      ),
                    ),
                    GestureDetector(
                      onTap: _navigateToMyDonations, // Add onTap callback
                      child: const ProfileWidget(
                        icon: Icons.card_giftcard_rounded,
                        title: 'Donations',
                      ),
                    ),
                    GestureDetector(
                      onTap: _logout, // Add onTap callback
                      child: const ProfileWidget(
                        icon: Icons.logout,
                        title: 'Log Out',
                      ),
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
