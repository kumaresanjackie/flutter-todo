import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/Services/auth_service.dart';
import 'package:tutorial/pages/add_todo_page.dart';
import 'package:tutorial/pages/homepage.dart';
import 'package:tutorial/pages/signup_page.dart';
import 'package:tutorial/pages/singin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentpage = SignUp();
  AuthCalss authCalss = AuthCalss();
  @override
  void initState() {
    // TODO: implement initState
    checkLogin();
    super.initState();
  }

  void checkLogin() async {
    String? token = await authCalss.getToken();
    if (token != null) {
      setState(() {
        currentpage = HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: currentpage,
    );
  }
}
