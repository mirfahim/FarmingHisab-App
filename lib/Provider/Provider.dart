import 'package:farming_app/Variables/Variables.dart';
import 'package:flutter/material.dart';

class ProviderServicePage extends ChangeNotifier{

  var sumProvider;

  void sumAmount(){

    sumProvider =
      Variables.depositAmount- Variables.expenseAmount ;

    notifyListeners();
  }
}