import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<String> notifications = [
    'Bildirim 1',
    'Bildirim 2',
    'Bildirim 3',
    'Bildirim 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bildirimler'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationCard(text: notifications[index]);
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String text;

  const NotificationCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(text),
      ),
    );
  }
}
