import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Variables{
  static Variables to = Variables();
  initial()async{
    prefss = await SharedPreferences.getInstance();
  }
  SharedPreferences prefss;
  static String token;
  static String appBarName;
  static String collectionNameID;
  static int depositAmount = 0;
  static int expenseAmount = 0;
  static var selectCate;
  static int foodAmount;
  static int labourAmount;
  static String password = "0";
  static var fireBasePath = FirebaseFirestore.instance
      .collection("AllFarm")
      .doc("AllFarmDoc")
      .collection("${Variables.collectionNameID}");
}