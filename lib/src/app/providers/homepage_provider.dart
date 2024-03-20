import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_exprense_tracker/src/widgets/shared_pref.dart';

final homePageProvider = ChangeNotifierProvider((ref) => HomePageProvider());

class HomePageProvider extends ChangeNotifier {
  //delete expense
  void deleteExpense(int index) async {
    expenseDB.removeAt(index);
    await saveExpenseToSharedPref(expenseDB);
    getExpenseFromSharePref();
    notifyListeners();

    return null;
  }
}
