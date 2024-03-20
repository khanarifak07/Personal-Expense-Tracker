import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_exprense_tracker/src/app/models/expense_model.dart';
import 'package:personal_exprense_tracker/src/app/providers/add_expense_provider.dart';
import 'package:personal_exprense_tracker/src/widgets/K_textfield.dart';
import 'package:personal_exprense_tracker/src/widgets/shared_pref.dart';

class AddExpense extends ConsumerStatefulWidget {
  final Expense? expense;
  final int? index;
  const AddExpense({super.key, this.expense, this.index});

  @override
  ConsumerState<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends ConsumerState<AddExpense> {
  late TextEditingController amountCtrl =
      TextEditingController(text: widget.expense?.amount.toString());
  late TextEditingController descriptionCtrl =
      TextEditingController(text: widget.expense?.description);
  late DateTime _selectedDate = widget.expense?.date ?? DateTime.now();
  @override
  Widget build(BuildContext context) {
    final addExpensePro = ref.watch(addExpenseProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        title: Text(
          "Add Amount",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Amount",
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            KTextField(
              controller: amountCtrl,
              textFontSize: 40,
              prefixImage: Image.asset(
                'assets/dollar.png',
                scale: 12,
              ),
              suffix: "USD",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Date",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      addExpensePro.dateFormat
                          .format(addExpensePro.selectedDate),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    addExpensePro.selectDate(context);
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(.3),
                    ),
                    child: const Icon(Icons.keyboard_arrow_down, size: 35),
                  ),
                )
              ],
            ),
            const SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                KTextField(
                  maxLines: 5,
                  controller: descriptionCtrl,
                  keyboardType: TextInputType.text,
                )
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.maxFinite,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () async {
                  if (widget.expense == null) {
                    if (amountCtrl.text.isNotEmpty &&
                        descriptionCtrl.text.isEmpty) {}
                    //create expense instance
                    Expense newExpense = Expense(
                      amount: int.parse(amountCtrl.text),
                      date: _selectedDate,
                      description: descriptionCtrl.text,
                    );
                    //get the expense
                   expenseDB = await getExpenseFromSharePref();
                    //add to expense databse
                    expenseDB.add(newExpense);
                    //save to shared pref
                    await saveExpenseToSharedPref(expenseDB);
                    //clear the controllers
                    amountCtrl.clear();
                    _selectedDate = DateTime.now();
                    descriptionCtrl.clear();
                    Navigator.of(context).pop();
                  } else {
                    expenseDB[widget.index!] = Expense(
                      amount: int.parse(amountCtrl.text),
                      date: _selectedDate,
                      description: descriptionCtrl.text,
                      //
                    );
                    await saveExpenseToSharedPref(expenseDB);
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  widget.expense == null ? "Add" : "Update",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
