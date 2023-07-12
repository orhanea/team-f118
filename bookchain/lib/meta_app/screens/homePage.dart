import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookchain/meta_app/screens/addDonation.dart';
import 'package:bookchain/meta_app/screens/notificationPage.dart';
import 'package:bookchain/meta_app/screens/profileScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
  
  int completedGoals = 0;
  bool isDonationButtonEnabled = false;

  List<VBarChartModel> bardata = [
    const VBarChartModel(
      index: 0,
      label: "Pazartesi",
      colors: [Colors.orange, Colors.deepOrange],
      jumlah: 20,
      tooltip: "20 Pcs",
      description: Text(
        "Most selling fruit last week",
        style: TextStyle(fontSize: 10),
      ),
    ),
    const VBarChartModel(
      index: 1,
      label: "Salı",
      colors: [Colors.orange, Colors.deepOrange],
      jumlah: 55,
      tooltip: "55 Pcs",
      description: Text(
        "Most selling fruit this week",
        style: TextStyle(fontSize: 10),
      ),
    ),
    const VBarChartModel(
      index: 2,
      label: "Çarşamba",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 12,
      tooltip: "12 Pcs",
    ),
    const VBarChartModel(
      index: 3,
      label: "Perşembe",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 5,
      tooltip: "5 Pcs",
    ),
    const VBarChartModel(
      index: 4,
      label: "Cuma",
      colors: [Colors.orange, Colors.deepOrange],
      jumlah: 15,
      tooltip: "15 Pcs",
    ),
    const VBarChartModel(
      index: 5,
      label: "Cumartesi",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 30,
      tooltip: "30 Pcs",
      description: Text(
        "Favorites vegetables",
        style: TextStyle(fontSize: 10),
      ),
    ),
    const VBarChartModel(
      index: 6,
      label: "Pazar",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 30,
      tooltip: "40 Pcs",
      description: Text(
        "Favorites vegetables",
        style: TextStyle(fontSize: 10),
      ),
    ),
  ];

  Future<void> _fetchCompletedGoals() async {

    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot completedGoalsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserUid)
        .collection('goals')
        .where('completed', isEqualTo: true) // Complete the goal
        .get();

    int completedGoalsCount = completedGoalsSnapshot.size;

    setState(() {
      completedGoals = completedGoalsCount; // Update completed goals count

      if (completedGoalsCount >= 5) {
        isDonationButtonEnabled = true; // Activate the donation button
      } else {
        isDonationButtonEnabled = false; // Deactivate the donation button
      }
    });
  }

  late User? currentUser;
  String? userName;
  int? progress = 12;
  final colors = <Color>[Colors.lime, Colors.pink, Colors.cyan];

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    fetchUserName();
    _fetchCompletedGoals(); // Fetch completed goals data
  }

  Future<void> fetchUserName() async {
    if (currentUser != null) {
      await currentUser!.reload();
      setState( () {
          userName = currentUser!.displayName;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,

        //asagısı sıkıntılı ayar cekılcek
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.person,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationPage(),
                  ),
                );
              },
              child: Icon(
                Icons.notifications,
                color: Colors.black,
              )),
          SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            //color: Colors.white,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //progress container
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  margin: const EdgeInsets.all(20),
                  /*decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.amber),*/
                  width: double.infinity,
                  child: CircularPercentIndicator(
                    radius: 90,
                    lineWidth: 15,
                    backgroundColor: Colors.black12,
                    progressColor: Colors.deepPurpleAccent,
                    percent: 0.6,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$progress%",
                          style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff000000),
                          ),
                        ),
                        const Text(
                          "Progress",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animationDuration: 2000,
                  ),
                ),

                VerticalBarchart(
                  maxX: 55,
                  data: bardata,
                  showLegend: false,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: isDonationButtonEnabled
                      ? () {
                    // Activate donate button functionality
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddDonationPage()),
                    );
                  }
                      : null, // Deactivate donate button
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      isDonationButtonEnabled
                          ? Colors.indigoAccent
                          : Colors.grey, // Set button color based on completion status
                    ),
                  ),
                  child: Text(
                    'Bağış Yap',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
