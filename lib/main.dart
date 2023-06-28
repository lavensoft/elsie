import 'package:flutter/material.dart';
import 'package:elsie/screens/Home/Home.dart';
import 'package:elsie/screens/Auth/Login/Login.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColorLight: const Color.fromRGBO(0, 165, 156, 1),
        primaryColor: Colors.white,
        fontFamily: "GoogleSansPlus",
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle( //<-- SEE HERE
            // Status bar color
            statusBarColor: Colors.white,
            systemNavigationBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      initialRoute: "/",
      routes: {
        "/login": (context) => const LoginScreen(),
        "/" : (context) => const HomeScreen(),
      }
    );
  }
}