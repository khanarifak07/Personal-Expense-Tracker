import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:personal_exprense_tracker/src/app/providers/add_expense_provider.dart';
import 'package:personal_exprense_tracker/src/app/providers/homepage_provider.dart';
import 'package:personal_exprense_tracker/src/app/screens/add_expense.dart';
import 'package:personal_exprense_tracker/src/widgets/expense_list.dart';
import 'package:personal_exprense_tracker/src/widgets/shared_pref.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData(); // Initial fetch data
  }

  void loadData() async {
    expenseDB = await getExpenseFromSharePref();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final homePagePro = ref.watch(homePageProvider);
    final addExpensePro = ref.watch(addExpenseProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/menu.png',
          scale: 15,
        ),
        title: Text(
          "Dashboard",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: CircleAvatar(
              radius: 25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/profile.jpg',
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: Theme.of(context).colorScheme.primary,
              ),
              height: 180,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/dollar.png",
                      color: Colors.white, scale: 15),
                  const SizedBox(width: 10),
                  Text(
                    addExpensePro.getTotalAmount().toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    "USD",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 20),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "All Expenses",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 35.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await addExpensePro.selectDateRange(context);
                    },
                    child: const Text("Filter By Date"),
                    /* child: Text(_startDate != null && _endDate != null
                        ? 'Selected Date Range ${DateFormat.yMMMd().format(_startDate!)}- ${DateFormat.yMMMd().format(_endDate!)}'
                        : "Select Date Range"), */
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (addExpensePro.startDate != null && addExpensePro.endDate != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    '${DateFormat.yMMMd().format(addExpensePro.startDate!)} - ${DateFormat.yMMMd().format(addExpensePro.endDate!)}'),
                TextButton(
                    onPressed: () {
                      addExpensePro.clearFilters();
                    },
                    child: const Text("Clear Filters"))
              ],
            ),
          for (var expense in addExpensePro.getFilteredExpenses())
            ExpenseList(
              amount: expense.amount,
              description: expense.description,
              date: DateFormat.yMMMd().format(expense.date),
              deleteExpense: (context) =>
                  homePagePro.deleteExpense(expenseDB.indexOf(expense)),
              ontap: () async {
                addExpensePro.initEdit(expense);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddExpense(
                      expense: expense,
                      index: expenseDB.indexOf(expense),
                    ),
                  ),
                );
                setState(() {});
              },
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        onPressed: () async {
          addExpensePro.clearCtrl();
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddExpense()));

          setState(() {
            getExpenseFromSharePref();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
