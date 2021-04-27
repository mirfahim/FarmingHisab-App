import 'package:farming_app/Pages/Authentication/PaymentConfirm.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:farming_app/Pages/Admin/DepositFormPage.dart';
import 'package:farming_app/Pages/HomePages.dart';


import 'Pages/Authentication/LoginUser.dart';
import 'Pages/Authentication/SignUpForm.dart';
import 'Pages/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(

      ),
    );
  }
}

