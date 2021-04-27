import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:farming_app/Variables/Variables.dart';
import 'package:farming_app/Widgets/myDrawer.dart';

class Deposit extends StatefulWidget {
  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  String month = "2021-04-30";
  int year = 2021;
  int day = 01;
 var start = DateTime.monthsPerYear;
  var end = DateTime.parse("2021-04-30");
  var selectDoc;
  var selectIndex;
  var docID = "DepositDoc";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Total:${Variables.depositAmount}"),
      ),
      drawer: MyDrawer(),
      body: StreamBuilder(
          stream: Variables.fireBasePath
              .doc(docID)
              .collection("Deposit")
              .where('date', isGreaterThan: start)
              .where('date', isLessThan: end)
           //   .orderBy('date', descending: true)
             // .where('month', isEqualTo: 'April')

              .snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                print("${snapshot.data.docs.length} HOCCHHE NAAAAAA");
                DocumentSnapshot documentSnapshot = snapshot.data.docs[index];

                DateTime date = documentSnapshot.data()["date"].toDate();
                var newDate = DateFormat.yMMMd().format(date);
                print(
                    "${documentSnapshot.data()["memberAmount"]} VIIIIIVVVIIII");

                return Card(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectDoc = documentSnapshot.id;
                        selectIndex = index;
                      });
                    },
                    child: Container(
                      color: selectIndex == index ? Colors.blue : Colors.white,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                newDate,
                                style: TextStyle(fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "Deposit",
                                style: TextStyle(fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.blue.withOpacity(.1),
                            ),
                            title: Text(documentSnapshot
                                .data()["memberName"]
                                .toString()),
                            trailing: Text(documentSnapshot
                                .data()["memberAmount"]
                                .toString()),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}

//new
