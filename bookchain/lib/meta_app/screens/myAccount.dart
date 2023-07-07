import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _errorMessage;
  File? _avatarImage;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userData =
        FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    final picsCollection = FirebaseFirestore.instance.collection('pics');

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: userData.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!.data() as Map<String, dynamic>;
              final username = data['username'] as String;
              final email = data['email'] as String;

              _usernameController.text = username;
              _emailController.text = email;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: _selectAvatarImage,
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: _avatarImage != null
                          ? FileImage(_avatarImage!) as ImageProvider<Object>
                          : AssetImage('assets/images/profile.png')
                              as ImageProvider<Object>,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'E-posta',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _updateProfile,
                    child: const Text('Profili Düzenle'),
                  ),
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error fetching user data');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<void> _selectAvatarImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
              child: const Text("Gallery"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.camera),
              child: const Text("Camera"),
            ),
          ],
        );
      },
    );

    if (pickedImage != null) {
      final pickedImageFile = await imagePicker.pickImage(source: pickedImage);

      if (pickedImageFile != null) {
        setState(() {
          _avatarImage = File(pickedImageFile.path);
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userData =
        FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    final picsCollection = FirebaseFirestore.instance.collection('pics');

    final updatedUsername = _usernameController.text.trim();
    final updatedEmail = _emailController.text.trim();

    try {
      if (_avatarImage != null) {
        final imageName = '${currentUser.uid}_profile.jpg';
        final storageRef =
            firebase_storage.FirebaseStorage.instance.ref().child(imageName);
        await storageRef.putFile(_avatarImage!);
        final imageUrl = await storageRef.getDownloadURL();

        await userData.update({
          'username': updatedUsername,
          'email': updatedEmail,
        });

        await picsCollection.doc(currentUser.uid).set({
          'avatarUrl': imageUrl,
        });
      } else {
        await userData.update({
          'username': updatedUsername,
          'email': updatedEmail,
        });
      }

      setState(() {
        _errorMessage = null;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to update profile. Please try again.';
      });
    }
  }
}
