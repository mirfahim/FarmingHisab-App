import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/Variables/Variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:farming_app/Widgets/myDrawer.dart';

class ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
 var expenseDoc = "expenseDoc";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense List"),
      ),
      drawer: MyDrawer(),
      body: Container(
        height: 550,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
            .collection("AllFarm")
            .doc("AllFarmDoc")
                .collection("${Variables.collectionNameID}")
            .doc(expenseDoc)
            .collection("Expense")

                .orderBy('date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {

                  print("${snapshot.data.docs.length} HOCCHHE NAAAAAA");
                  DocumentSnapshot documentSnapshot =
                  snapshot.data.docs[index];

                  DateTime date = documentSnapshot
                      .data()["date"].toDate();
                  var newDate = DateFormat.yMMMd().format(date);
                  print(
                      "${documentSnapshot.data()["amount"]} VIIIIIVVVIIII");



                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "details", arguments: "")
                            .then((value) => {
                          if (value != null)
                            {
                              if (value) {}
                            }
                        });
                      },
                      child: Container(
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
                                  "Expense: ${documentSnapshot
                                      .data()["category"]
                                      .toString()}",
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
                                child: Text("${index + 1}"),

                              ),
                              title: Text(documentSnapshot
                                  .data()["memo"]
                                  .toString()),
                              trailing:
                              Text(documentSnapshot
                                  .data()["amount"]
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
      ),
    );
  }
}