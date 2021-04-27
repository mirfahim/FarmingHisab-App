 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/Pages/HomePages.dart';
import 'package:farming_app/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container (
      child:Column(
        children: [
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
              onChanged: (String mobile) {
                getMobile(mobile);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Trex ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  )),
              onChanged: (String trex) {
                getTrex(trex);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Amount",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  )),
              onChanged: (String trex) {
                getTrex(trex);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: ()async {
                    // _form.currentState.validate();

                    createData();
                  },
                  child: Text("Create")),


            ],

          ),
        ],
      ),
      ),
    );
  }

  createData()async {

    Variables.to.prefss = await SharedPreferences.getInstance();
    Variables.collectionNameID = Variables.to.prefss.getString("Login_Token");
    print("${Variables.collectionNameID}");
    final QuerySnapshot result =
    await FirebaseFirestore.instance.collection('AllFarm').doc("AllFarmDoc").collection("${Variables.collectionNameID}").doc("FarmInfoDoc").collection("FarmInfo").where('payment', isEqualTo:
    "done").get();

    final List < DocumentSnapshot > documents = result.docs;


    if ( documents.length > 0){

      DocumentReference documentReference =
      FirebaseFirestore.instance.collection("AllFarm").doc("${"AllFarmDoc"}").collection("${Variables.collectionNameID}").doc(docID);
      Map<String, dynamic> memberInfo = {
        "mobile": mobileNo,
        "trexID": trexId,
        "amount": amount,

        "date": DateTime.now(),
      };
      documentReference.set(memberInfo).whenComplete(() {

      });


      Route route = MaterialPageRoute(builder: (c) => HomePage());
      Navigator.pushReplacement(context, route);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Text('You have to complete the payment'),
          duration: Duration(seconds: 2),
        ),
      );
    }


  }
var amount;
  var mobileNum ;
  var trexId;
  var mobileNo;
   String docID = "Payment";


  getMobile(mobileNo) {
    this.mobileNum = mobileNo;
  }
  getTrex(farmType) {
    this.trexId = trexId;
  }
  getAmount(amount) {
    this.amount = amount;
  }


}
