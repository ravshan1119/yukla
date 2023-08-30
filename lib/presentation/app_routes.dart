import 'package:flutter/material.dart';
import 'package:yukla/data/models/user/user_model.dart';
import 'package:yukla/presentation/auth/gmail_confirm/gmail_confirm_screen.dart';
import 'package:yukla/presentation/auth/pages/login_screen.dart';
import 'package:yukla/presentation/auth/pages/register_screen.dart';
import 'package:yukla/presentation/splash/splash_screen.dart';
import 'package:yukla/presentation/tab/tab_box.dart';
import 'package:yukla/presentation/tab/websites/sub_screens/add_website_screen.dart';

class RouteNames {
  static const String splashScreen = "/";
  static const String loginScreen = "/auth_screen";
  static const String registerScreen = "/register_screen";
  static const String tabBox = "/tab_box";
  static const String confirmGmail = "/confirm_gmail";
  static const String addWebsite = "/add_website";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (context) {
          return LoginScreen();
        });

      case RouteNames.registerScreen:
        return MaterialPageRoute(builder: (context) {
          return RegisterScreen();
        });

      case RouteNames.tabBox:
        return MaterialPageRoute(builder: (context) => TabBox());

      case RouteNames.addWebsite:
        return MaterialPageRoute(builder: (context) => AddWebsiteScreen());

      case RouteNames.confirmGmail:
        return MaterialPageRoute(
            builder: (context) => GmailConfirmScreen(
                  userModel: settings.arguments as UserModel,
                ));

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route mavjud emas"),
            ),
          ),
        );
    }
  }
}
