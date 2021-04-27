import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/Variables/Variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:farming_app/Pages/HomePages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String memberName;
  String memberAmount;
  var docID = "FarmInfoDoc";
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Form(
        key: _form,
        child: ListView(
          children: [
            Container(
              child: Column(

                children: [
                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Farm Name",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          )),
                      onChanged: (String farmName) {
                        getFarmName(farmName);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Farm ID",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          )),
                      onChanged: (String farmID) {
                        getFarmID(farmID);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Mobile No",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          )),
                      onChanged: (String mobileNo) {
                        getMobileNo(mobileNo);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Email",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          )),
                      onChanged: (String email) {
                        getEmail(email);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Admin Name",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          )),
                      onChanged: (String adminName) {
                        getAdminName(adminName);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Business Type",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          )),
                      onChanged: (String farmType) {
                        getFarmType(farmType);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "District",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          )),
                      onChanged: (String district) {
                        getDistrict(district);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (val){
                        if(val.isEmpty) {
                          return 'Empty';
                        } else if (val.length < 4) {
                          return "Password must be atleast 4 characters long";
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                          labelText: "Admin Password",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          )),
                      onChanged: (String adminPass) {
                        getAdminName(adminPass);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (val){
                        if(val.isEmpty)

                          return 'Empty';
                        if(val != adminPass.text)
                          print(val);
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Admin Password Check",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          )),
                      onChanged: (String checkpass) {
                        getAdminCheckPass(checkpass);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: ()async {
                           // _form.currentState.validate();


                            Route route = MaterialPageRoute(builder: (c) => HomePage());
                            Navigator.pushReplacement(context, route);
                            createData();
                          },
                          child: Text("Create")),


                    ],

                  ),
                ],
              ),


            ),
          ],

        ),
      ),
    );
  }
  createData()async {



      DocumentReference documentReference =
      FirebaseFirestore.instance.collection("AllFarm").doc("AllFarmDoc").collection(farmName+farmID).doc(docID).collection("FarmInfo").doc(docID);
      Map<String, dynamic> memberInfo = {
        "farmName": farmName,
        "farmID": farmID,
        "mobileNo": mobileNo,
        "typeOfBusiness": mobileNo,
        "email": email,
        "adminName": adminName,
        "district": district,
        "role": "admin",
        "date": DateTime.now(),
      };
      documentReference.set(memberInfo).whenComplete(() {
        print("${farmName+farmID} created ki hoiche");
      });
      Variables.to.prefss = await SharedPreferences.getInstance();

      String myValue = farmName+farmID;
      String appBar = farmName;
      Variables.to.prefss.setString("Login_Token", myValue);
      Variables.collectionNameID = Variables.to.prefss.getString("Login_Token");

      Variables.to.prefss.setString("Appbar", appBar);
      Variables.appBarName = Variables.to.prefss.getString("Appbar");
      Route route = MaterialPageRoute(builder: (c) => HomePage(appBarName: farmName,));
      Navigator.pushReplacement(context, route);

  }

  var farmName ;
  var farmID;
  var mobileNo;
  var typeOfBusiness;
  var email;
  var farmType;
  var adminName;
  var district;
  var adminPass;
  var checkPass;


  getFarmName(farmName) {
    this.farmName = farmName;
  }
  getFarmType(farmType) {
    this.farmType = farmType;
  }

  getFarmID(farmID) {
    this.farmID = farmID;
  }
  getMobileNo(mobileNo) {
    this.mobileNo = mobileNo;
  }
  getTypeOfBusiness(typeOfBusiness) {
    this.typeOfBusiness = typeOfBusiness;
  }
  getEmail(email) {
    this.email = email;
  }
  getAdminName(adminName) {
    this.adminName = adminName;
  }
  getDistrict(district) {
    this.district = district;
  }
  getAdminPass(adminPass){
    this.adminPass = adminPass;
  }
  getAdminCheckPass(adminCheckPass){
    this.checkPass = adminCheckPass;
  }
}
