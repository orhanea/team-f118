import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookchain/meta_app/helpers/constants/strings.dart';

class CreateNewGoal extends StatefulWidget {
  const CreateNewGoal({Key? key}) : super(key: key);

  @override
  State<CreateNewGoal> createState() => _CreateNewGoalState();
}

class _CreateNewGoalState extends State<CreateNewGoal> {
  late User? currentUser;
  String? userName;
  String? selectedFrequency;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    if (currentUser != null) {
      await currentUser!.reload();
      setState(() {
        userName = currentUser!.displayName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create New Goal',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 25.0), // Adjust the padding as needed
                    child: Icon(
                      Icons.landscape,
                      color: Colors.blue,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Date',
                        labelStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 25.0), // Adjust the padding as needed
                    child: Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.blue,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Add Task',
                  labelStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                  prefixIcon: Icon(
                    Icons.add_circle,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedFrequency,
                onChanged: (newValue) {
                  setState(() {
                    selectedFrequency = newValue;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'Daily',
                    child: Text(
                      'Daily',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Weekly',
                    child: Text(
                      'Weekly',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Monthly',
                    child: Text(
                      'Monthly',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Start time',
                        labelStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                        prefixIcon: Icon(Icons.access_time),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Add a small gap
                  Flexible(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'End time',
                        labelStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                        prefixIcon: Icon(
                          Icons.access_time,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Tap to add notes',
                  labelStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: Icon(Icons.edit),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Handle create goal button press
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    'Create Goals',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w300,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
