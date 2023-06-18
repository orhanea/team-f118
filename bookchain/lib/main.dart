import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bookchain/meta_app/screens/onbarding.dart';

// ignore: unused_import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.urbanistTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          return AnimatedSplashScreen(
            splash: const Image(
              image: AssetImage('assets/images/ouap.png'),
              height: 300.0,
              width: 300.0,
            ),
            duration: 3000,
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: const Color.fromARGB(255, 236, 236, 236),
            nextScreen: const OnBoarding(),
          );
        }
      ),
    );
  }
}
