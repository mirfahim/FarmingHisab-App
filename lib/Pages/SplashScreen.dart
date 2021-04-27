import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/Pages/Authentication/SignUpForm.dart';
import 'package:farming_app/Pages/Authentication/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:farming_app/Pages/HomePages.dart';
import 'package:farming_app/Variables/Variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var farmInfoDoc = "FarmInfoDoc";
  Color color = Colors.white;
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () async {
      Variables.to.prefss = await SharedPreferences.getInstance();

      Variables.collectionNameID = Variables.to.prefss.getString("Login_Token");
      print("${Variables.collectionNameID}");
      print("${Variables.depositAmount}");
      setState(() {
        color = color == Colors.white ? Colors.grey : Colors.white;
      });
      Variables.to.prefss.getString("Login_Token") == null
          ? Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WelcomeScreen()))
          :
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));


    });


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Colors.blue, Colors.blue[800]],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Container(
              height: 250,
              width: 250,
              child: Image(
                image: AssetImage("assets/icons/wallet.png"),
              ),
            ),
          ),


        ],
      ),
    );
  }
@override
  void setState(fn) {

    super.setState(fn);
  }
  var depositAmount;
  var expenseAmount;
}
