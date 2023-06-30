import "package:flutter/material.dart";
import "package:test4/pages/login.dart";
import "package:test4/pages/home.dart";
import "package:test4/pages/sign.dart";
import "package:test4/routes.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: {
        TestRoutes.login:(context)=>const LoginPage(),
        TestRoutes.home:(context)=>const HomePage(),
        TestRoutes.success:(context)=>SuccessPage(),
      },
      onGenerateRoute: (settings){
        switch (settings.name){
          case TestRoutes.root:
            return MaterialPageRoute(builder:(context) => const LoginPage());
          default:
            return MaterialPageRoute(builder:(context) => const LoginPage());
        }
      },
    );
  }
}