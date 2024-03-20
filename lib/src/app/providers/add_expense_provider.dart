import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:personal_exprense_tracker/src/widgets/shared_pref.dart';

final addExpenseProvider =
    ChangeNotifierProvider((ref) => AddExpenseProivder());

class AddExpenseProivder extends ChangeNotifier {
  TextEditingController amountCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  //select date method
  DateTime selectedDate = DateTime.now();

  //date format
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  //Select date method
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2024),
        lastDate: DateTime(2030),
        initialDate: DateTime.now());

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      notifyListeners();
    }
  }

  //get total amount from expense
  double getTotalAmount() {
    double total = 0.0;
    for (var expense in expenseDB) {
      total += expense.amount;
    }
    return total;
  }
}
