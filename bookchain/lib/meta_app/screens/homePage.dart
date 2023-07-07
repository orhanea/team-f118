import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User? currentUser;
  String? userName;
  int? progress = 12;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    if (currentUser != null) {
      await currentUser!.reload();
      setState(
        () {
          userName = currentUser!.displayName;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        leading: Icon(Icons.person),
      ),
      body: Center(
        child: Container(
          color: Colors.grey[100],
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 120,
                lineWidth: 30,
                backgroundColor: Colors.grey,
                progressColor: Colors.red,
                percent: 0.6,
                center: Text(
                  "$progress",
                  style: const TextStyle(fontSize: 20),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                animation: true,
                animationDuration: 2000,
                onAnimationEnd: () {
                  print("Animation finished");
                },
                header: const Text(
                  "Task Progress",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
