import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookchain/meta_app/helpers/routers/constant_route.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  final String? userName = FirebaseAuth.instance.currentUser?.displayName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Homepage"),
      ),
      body: Column(
        children: [
          Text("Hello $userName"),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.push(context, ConstRoutes.welcomeScreenRoute as Route<Object?>);
              },
              child: const Text("Sign Out"))
        ],
      ),
    );
  }
}