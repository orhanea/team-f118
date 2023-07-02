import 'package:flutter/material.dart';

import 'createNewGoal.dart';
import 'homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chain App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChainPage(),
      routes: {
        '/createNewGoal': (context) => CreateNewGoal(),
      },
    );
  }
}

enum ChainPageState {
  Home,
  CreateNewGoal,
  Goals,
}

class ChainPage extends StatefulWidget {
  @override
  _ChainPageState createState() => _ChainPageState();
}

class _ChainPageState extends State<ChainPage> {
  ChainPageState _currentPage = ChainPageState.Home;

  void _navigateToPage(ChainPageState pageState) {
    setState(() {
      _currentPage = pageState;
    });
  }

  Widget _buildCurrentPage() {
    switch (_currentPage) {
      case ChainPageState.Home:
        return HomePage();
      case ChainPageState.CreateNewGoal:
        return CreateNewGoal();
      case ChainPageState.Goals:
        return GoalsPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chain App'),
      ),
      body: _buildCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage.index,
        onTap: (index) {
          if (index == ChainPageState.CreateNewGoal.index) {
            _navigateToPage(ChainPageState.CreateNewGoal);
          } else if (index == ChainPageState.Goals.index) {
            _navigateToPage(ChainPageState.Goals);
          } else {
            _navigateToPage(ChainPageState.Home);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Goals',
          ),
        ],
      ),
    );
  }
}

class GoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals'),
      ),
      body: Center(
        child: Text(
          'Goals Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
