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
      ),
      body: Center(
        child: Container(
            color: Colors.grey[100],
            margin: const EdgeInsets.all(20),
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
                    "60%",
                    style: TextStyle(fontSize: 20),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animationDuration: 2000,
                  onAnimationEnd: () {
                    print("Animation finished");
                  },
                  header: Text(
                    "Task Progress",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                LinearPercentIndicator(
                  width: 180,
                  lineHeight: 30,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                  percent: 0.8,
                  center: Text(
                    "80%",
                    style: TextStyle(fontSize: 20),
                  ),
                  alignment: MainAxisAlignment.center,
                  animation: true,
                  animationDuration: 1000,
                  onAnimationEnd: () {
                    print("Linear Animation finished");
                  },
                  barRadius: Radius.circular(20),
                  leading: Text(
                    "Task Progress",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
