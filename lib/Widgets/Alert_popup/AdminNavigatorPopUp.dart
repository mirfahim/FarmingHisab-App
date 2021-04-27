
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:farming_app/Pages/Admin/AdminPage.dart';
import 'package:farming_app/Pages/Admin/ExpenseForm.dart';
import 'package:farming_app/Pages/Admin/DepositFormPage.dart';
import 'package:farming_app/Variables/Variables.dart';



class AdminNavPopup extends StatefulWidget {
  @override
  _AreYouSureState createState() => _AreYouSureState();
}

class _AreYouSureState extends State<AdminNavPopup> {

  TextEditingController passController = TextEditingController();
  String password = "123";
  String pass;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content:  Container(
        height: 80,
        child: Column(
          children: [
            Text("You are not Admin"),
            Text("Contact with your Admin to get access"),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Okay'),
          onPressed: (){
            Navigator.of(context).pop(false);
          },
        ),

      ],

    );
  }
}