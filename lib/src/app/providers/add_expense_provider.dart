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

  //to pass the model data while editing the expense
  void initEdit(Expense expense) {
    amountCtrl.text = expense.amount.toString();
    selectedDate = expense.date;
    descriptionCtrl.text = expense.description;
  }

  //to clear the controller while adding new expense
  void clearCtrl() {
    amountCtrl.clear();
    descriptionCtrl.clear();
    selectedDate = DateTime.now();
  }

//Date format
  DateFormat dateFormat = DateFormat.yMMMd();
  //select date method
  DateTime selectedDate = DateTime.now();
  //Select date method
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: selectedDate,
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      notifyListeners();
    }
  }

  //Filter based on date range
  //start and end date object
  DateTime? startDate;
  DateTime? endDate;
  //date range picker method
  Future<void> selectDateRange(BuildContext context) async {
    final DateTimeRange? pickedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (pickedRange != null) {
      startDate = pickedRange.start;
      endDate = pickedRange.end;
      notifyListeners();
    }
  }

  //based on start and end data create filter method
  List<Expense> getFilteredExpenses() {
    if (startDate == null || endDate == null) {
      // If start or end date is not selected, return all expenses
      return expenseDB;
    } else {
      // Filter expenses based on selected date range
      final filteredExpenses = expenseDB.where((expense) {
        final isAfterStart = expense.date.isAtSameMomentAs(startDate!) ||
            expense.date.isAfter(startDate!);
        final isBeforeEnd = expense.date.isAtSameMomentAs(endDate!) ||
            expense.date.isBefore(endDate!);
        return isAfterStart && isBeforeEnd;
      }).toList();

      return filteredExpenses;
    }
  }

  //clear filters
  void clearFilters() {
    startDate = null;
    endDate = null;
    notifyListeners();
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
