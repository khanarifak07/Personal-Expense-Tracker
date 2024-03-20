import 'package:personal_exprense_tracker/src/app/models/expense_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Expense> expenseDB = [];

//saving expenses to sharepref
saveExpenseToSharedPref(List<Expense> expenses) async {
  //share pref instance
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //convert model to list of string
  List<String> expenseJsonList = expenses.map((e) => e.toJson()).toList();
  //save the list of string to shared pref
  prefs.setStringList('expenses', expenseJsonList);
}

//getting expenses from shared pref
Future<List<Expense>> getExpenseFromSharePref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //retrive list of string from shared prefs
  List<String>? expenseJsonList = prefs.getStringList('expenses');
  //convert list of string to expense model
  List<Expense> expenses = expenseJsonList != null
      ? expenseJsonList.map((e) => Expense.fromJson(e)).toList()
      : [];
  return expenses;
}
