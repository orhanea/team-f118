import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  Map<DateTime, List<dynamic>> _events = {};
  late String currentUserUid;
  int completedGoals = 0;

  Future<void> _fetchEvents() async {
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot goalsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserUid)
        .collection('goals')
        .get();

    setState(() {
      _events = {};
      completedGoals = 0; // Reset the completed goals count
      for (QueryDocumentSnapshot goalDoc in goalsSnapshot.docs) {
        Map<String, dynamic>? goalData =
            goalDoc.data() as Map<String, dynamic>?;

        if (goalData != null) {
          DateTime goalDate = (goalData['date'] as Timestamp).toDate();
          String goalName = goalData['name'] as String;

          if (_events.containsKey(goalDate)) {
            _events[goalDate]!.add(goalName);
          } else {
            _events[goalDate] = [goalName];
          }
          if (goalData != null && goalData['completed']) {
            completedGoals++;
          }
        }
      }
    });
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  void initState() {
    super.initState();
    currentUserUid =
        FirebaseAuth.instance.currentUser!.uid; // Assign the value here
    _fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.0),
          Expanded(
            child: Column(
              children: [
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.all(16.0),
                  child: TableCalendar(
                    calendarFormat: _calendarFormat,
                    focusedDay: _focusedDay,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    eventLoader: _getEventsForDay,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        _selectedDay == null
                            ? 'Goals for the user'
                            : 'Goals for ${_selectedDay?.day}-${_selectedDay?.month}-${_selectedDay?.year}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedDay = null;
                        });
                      },
                      child: Text('Show All Goals'),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _selectedDay == null
                        ? FirebaseFirestore.instance
                            .collection('users')
                            .doc(currentUserUid)
                            .collection('goals')
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('users')
                            .doc(currentUserUid)
                            .collection('goals')
                            .where('date',
                                isEqualTo: Timestamp.fromDate(_selectedDay!))
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            'No goals found for $_selectedDay',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                            ),
                          ),
                        );
                      }

                      return ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        children: snapshot.data!.docs.map((goalDoc) {
                          final goalData =
                              goalDoc.data() as Map<String, dynamic>;

                          return Card(
                            elevation: 2.0,
                            margin: EdgeInsets.only(bottom: 8.0),
                            child: ListTile(
                              title: Text(
                                goalData['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Date: ${_formatTimestamp(goalData['date'])}',
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _formatTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return '${dateTime.day}-${dateTime.month}-${dateTime.year}';
}
