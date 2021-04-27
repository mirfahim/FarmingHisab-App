import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/Provider/Provider.dart';
import 'package:farming_app/Variables/Variables.dart';
import 'package:flutter/material.dart';

import 'package:farming_app/Widgets/textStyle.dart';
import 'package:farming_app/Widgets/uiHelper.dart';
import 'package:provider/provider.dart';

class SummaryWidget extends StatelessWidget {
  final int income;
  final int expense;

  const SummaryWidget({this.income, this.expense});






  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Column(
                children: <Widget>[
                  Text('Deposit', style: summaryTextStyle),
                  UIHelper.verticalSpaceSmall(),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("AllFarm")
                          .doc("AllFarmDoc")
                          .collection("${Variables.collectionNameID}")
                          .doc("DepositDoc")
                          .collection("Deposit")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return CircularProgressIndicator();
                        final documents = snapshot.data.docs;
                        Variables.depositAmount = documents.fold(
                            0, (s, n) => s + int.parse(n['memberAmount'].toString()));

                        return Text("${Variables.depositAmount}", style: summaryNumberTextStyle,);
                      }),
                ],
              ),
              Text(
                '|',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w200),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Expense',
                    style: summaryTextStyle,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("AllFarm")
                          .doc("AllFarmDoc")
                          .collection("${Variables.collectionNameID}")
                          .doc("expenseDoc")
                          .collection("Expense")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return CircularProgressIndicator();
                        final documents = snapshot.data.docs;
                        Variables.expenseAmount = documents.fold(
                            0, (s, n) => s + int.parse(n['amount'].toString()));

                        return Center(
                            child: Text(
                              "${Variables.expenseAmount}",
                              style: summaryNumberTextStyle,
                            ));
                      }),
                ],
              ),
              Text(
                '|',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w200),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Balance',

                    style: summaryTextStyle,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Consumer<ProviderServicePage>(

                    builder: (context, anything, _) {
                      var notifyCounter = Provider.of<ProviderServicePage>(context, listen: false);

                      return anything.sumProvider == null ? InkWell(
                          onTap:(){
                            notifyCounter.sumAmount();
                          },
                          child: Text("Tap to know", style: TextStyle(color: Colors.blue),))
                          :Text(anything.sumProvider.toString() ,
                          style: Variables.depositAmount > Variables.expenseAmount ?TextStyle( color: Colors.black, fontSize: 18, fontWeight:FontWeight.bold)
                              : TextStyle(color: Colors.red,fontSize: 18, fontWeight:FontWeight.bold));
                    }
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }
}
