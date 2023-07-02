import 'package:flutter/material.dart';
import 'createNewGoal.dart';
import 'goalsPage.dart';
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
  PageController _pageController =
      PageController(initialPage: ChainPageState.Home.index);

  void _navigateToPage(ChainPageState pageState) {
    int pageIndex = pageState.index;
    if (pageIndex > _currentPage.index) {
      _pageController.animateToPage(
        pageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else if (pageIndex < _currentPage.index) {
      _pageController.animateToPage(
        pageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
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

  Future<bool> _onWillPop() async {
    if (_currentPage != ChainPageState.Home) {
      _navigateToPage(ChainPageState.Home);
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dx > 0) {
              // Swiped right
              if (_currentPage == ChainPageState.Home) {
                _navigateToPage(ChainPageState.Goals);
              }
            } else if (details.velocity.pixelsPerSecond.dx < 0) {
              // Swiped left
              if (_currentPage == ChainPageState.Goals) {
                _navigateToPage(ChainPageState.Home);
              }
            }
          },
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              CreateNewGoal(),
              GoalsPage(),
            ],
          ),
        ),
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
      ),
    );
  }
}
