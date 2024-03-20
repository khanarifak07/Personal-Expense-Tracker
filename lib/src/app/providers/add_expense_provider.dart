import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:personal_exprense_tracker/src/app/models/expense_model.dart';
import 'package:personal_exprense_tracker/src/widgets/shared_pref.dart';

final addExpenseProvider =
    ChangeNotifierProvider((ref) => AddExpenseProivder());

class AddExpenseProivder extends ChangeNotifier {
  late Expense? expense;

  TextEditingController amountCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  //select date method
  DateTime selectedDate = DateTime.now();

  void initEdit(Expense expense) {
    amountCtrl.text = expense.amount.toString();
    selectedDate = expense.date;
    descriptionCtrl.text = expense.description;
  }

  void clearCtrl() {
    amountCtrl.clear();
    descriptionCtrl.clear();
    selectedDate = DateTime.now();
  }

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
