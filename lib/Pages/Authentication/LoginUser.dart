import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/Variables/Variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:farming_app/Pages/HomePages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLogin extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<UserLogin> {

  var docID = "FarmInfoDoc";


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: [
          Container(
            child: Column(

              children: [
                SizedBox(height: 40,),

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
                        labelText: "User Name",
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


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: ()async {
                          print("__IDDDDDDDDDD____$farmID");
                             Variables.collectionNameID = farmID;
                            print("__IDDDDDDDDDD____${Variables.collectionNameID}");
                          final QuerySnapshot result =
                          await FirebaseFirestore.instance.collection('AllFarm').doc("AllFarmDoc").collection(Variables.collectionNameID).doc("FarmInfoDoc").collection("user").where('name', isEqualTo:
                          email).get();

                          final List < DocumentSnapshot > documents = result.docs;
                            print("__IDDDDDDDDDD____$farmID");

                          if ( documents.length > 0){
                            Route route = MaterialPageRoute(builder: (c) => HomePage());
                            Navigator.pushReplacement(context, route);
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:Text('Fill all Details, Amount and select Category'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }

                          //createData();
                        },
                        child: Text("Create")),


                  ],

                ),
              ],
            ),


          ),
        ],

      ),
    );
  }
  loginUser()async {

    Variables.to.prefss = await SharedPreferences.getInstance();



    Variables.appBarName = Variables.to.prefss.getString("Appbar");
    Route route = MaterialPageRoute(builder: (c) => HomePage());
    Navigator.pushReplacement(context, route);

  }

  var email ;
  var farmID;
  var mobileNo;





  getFarmID(farmID) {
    this.farmID = farmID;
  }
  getMobileNo(mobileNo) {
    this.mobileNo = mobileNo;
  }

  getEmail(email) {
    this.email = email;
  }

}
