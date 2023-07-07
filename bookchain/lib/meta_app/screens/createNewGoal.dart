import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookchain/meta_app/helpers/constants/strings.dart';

import 'goalsPage.dart';

class CreateNewGoal extends StatefulWidget {
  const CreateNewGoal({Key? key}) : super(key: key);

  @override
  State<CreateNewGoal> createState() => _CreateNewGoalState();
}

class _CreateNewGoalState extends State<CreateNewGoal> {
  late User? currentUser;
  String? userName;
  String? selectedFrequency;
  DateTime? selectedDate;

  final _formKey = GlobalKey<FormState>(); // Create a global form key

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

  Future<void> selectDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void createGoal() {
    if (_formKey.currentState!.validate()) {
      // The form is valid, proceed with creating the goal
      final goalsCollection = FirebaseFirestore.instance.collection('goals');
      goalsCollection.add({
        'name': nameController.text,
        'date': selectedDate,
        'taskDetails': taskDetailsController.text,
        'frequency': selectedFrequency,
        'startTime': startTimeController.text,
        'endTime': endTimeController.text,
        'notes': notesController.text,
      }).then((value) {
        // Goal created successfully
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  GoalsPage()), // Replace GoalsPage with the actual page for goals
        );
      }).catchError((error) {
        // An error occurred while creating the goal
        // Handle the error accordingly
      });
    }
  }

  final nameController = TextEditingController();
  final taskDetailsController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final notesController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    taskDetailsController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assign the form key to the Form widget
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
                        controller: nameController,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
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
                      child: GestureDetector(
                        onTap: () {
                          selectDate(context);
                        },
                        child: AbsorbPointer(
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a date';
                              }
                              return null;
                            },
                            controller: TextEditingController(
                              // Set the text field value to the selected date
                              text: selectedDate != null
                                  ? selectedDate!.toString().split(' ')[0]
                                  : '',
                            ),
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
                  controller: taskDetailsController,
                  decoration: InputDecoration(
                    labelText: 'Add Task',
                    labelStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                    prefixIcon: const Icon(
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
                  value: selectedFrequency ??
                      'Daily', // Set the desired initial value
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
                        controller: startTimeController,
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
                        controller: endTimeController,
                        decoration: InputDecoration(
                          labelText: 'End time',
                          labelStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                          prefixIcon: const Icon(
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: notesController,
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
                  onPressed: createGoal,
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
      ),
    );
  }
}
