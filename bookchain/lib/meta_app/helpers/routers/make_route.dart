import 'package:flutter/material.dart';
import 'package:bookchain/meta_app/helpers/routers/constant_route.dart';
import 'package:bookchain/meta_app/screens/welcomeScreens.dart';
import 'package:bookchain/meta_app/screens/homePage.dart';
import 'package:bookchain/meta_app/screens/loginScreen.dart';
import 'package:bookchain/meta_app/screens/signupScreen.dart';
import 'package:bookchain/meta_app/screens/forgotPassword.dart';
import 'package:bookchain/meta_app/screens/passwordVerif.dart';

class MakeRoutes {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch ( settings.name ) {
      case ConstRoutes.homeScreenRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case ConstRoutes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case ConstRoutes.loginScreenRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case ConstRoutes.signupScreenRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case ConstRoutes.welcomeScreenRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case ConstRoutes.passwordVerificationRoute:
        return MaterialPageRoute(builder: (_) => const VerificationScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Yanlış giden birşeyler var.'),
            ),
          ),
        );
    }
  }

}