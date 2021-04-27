import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/Variables/Variables.dart';
import 'package:farming_app/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create User"),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    onChanged: (String name) {
                      getName(name);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Mobile no",
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
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    createData();
                  },
                  child: Text("Create")),

              // ElevatedButton(
              //     onPressed: () {
              //       updateData();
              //     },
              //     child: Text("Update")),
              // ElevatedButton(
              //     onPressed: () {
              //       deleteData();
              //     },
              //    child: Text("Delete")),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height*.6,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("AllFarm").doc("${Variables.collectionNameID}")
                    .collection("${Variables.collectionNameID}").doc(docId).collection("FarmInfo")
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {

                      print("${snapshot.data.docs.length} HOCCHHE NAAAAAA");
                      DocumentSnapshot documentSnapshot =
                      snapshot.data.docs[index];

                      DateTime date = documentSnapshot
                          .data()["date"].toDate();
                      var newDate = DateFormat.yMMMd().format(date);




                      return Card(

                        child: InkWell(
                          onTap: () {
                            print("Nothing");
                            print("DOC__ID_KI__PAICHE___${documentSnapshot.id}");
                            setState(() {
                              selectDoc = documentSnapshot.id;
                              selectIndex = index;
                            });


                          },
                          child: Container(
                            color:selectIndex == index ? Colors.blue :Colors.white,
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
                                      "Role: ${documentSnapshot
                                          .data()["role"]
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

                                  ),
                                  title: Text(documentSnapshot
                                      .data()["UserName"]
                                      .toString()),
                                  trailing:
                                  Text(documentSnapshot
                                      .data()["UserMobile"]
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
        ],
      ) ,
    );
  }
  createData() {

      DocumentReference documentReference = FirebaseFirestore.instance
      .collection("AllFarm")
      .doc("AllFarmDoc")
          .collection("${Variables.collectionNameID}")
          .doc(docId)
          .collection("FarmInfo")
          .doc();
      Map<String, dynamic> memberInfo = {
        "UserName": userName,
        "UserMobile": userMobile,
        "role": "user",
        "date": DateTime.now(),
      };
      documentReference.set(memberInfo).whenComplete(() {
        print("$userName created ki hoiche");
      });

    }
 var selectDoc ;
  var selectIndex ;


  var userName ;
  var userMobile;
String docId = "FarmInfoDoc";
  getName(name){
    this.userName = name;
  }
  getMobile(mobile){
    this.userMobile = mobile;
  }
}
