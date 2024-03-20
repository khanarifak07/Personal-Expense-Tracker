/* import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_exprense_tracker/src/app/models/expense_model.dart';

class KBottomSheet extends StatefulWidget {
  final Expense? expense;
  final int? index;
  const KBottomSheet({super.key, this.expense, this.index});

  @override
  State<KBottomSheet> createState() => _KBottomSheetState();
}

class _KBottomSheetState extends State<KBottomSheet> {
  late TextEditingController amountCtrl =
      TextEditingController(text: widget.expense?.amount.toString());
  late TextEditingController descriptionCtrl =
      TextEditingController(text: widget.expense?.description);
  late DateTime _selectedDate = widget.expense?.date ?? DateTime.now();

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Material(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          height: MediaQuery.of(context).size.height / 2.15,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                KTextField(
                  hint: "Amount",
                  controller: amountCtrl,
                ),
                const SizedBox(height: 10),
                KTextField(
                  ontap: () {
                    selectDate(context);
                  },
                  hint: _dateFormat.format(_selectedDate),
                  icon: Icons.date_range,
                  enabled: false,
                ),
                // const KTextField(hint: "Date"),
                const SizedBox(height: 10),
                KTextField(
                    hint: "Description",
                    maxLines: 5,
                    controller: descriptionCtrl),
                const SizedBox(height: 10),
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
        ),
      ),
    );
  }
}
 */