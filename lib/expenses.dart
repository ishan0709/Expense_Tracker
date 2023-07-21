import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/expense_list.dart';
import 'package:expense_tracker/open_form.dart';
import 'package:expense_tracker/chart.dart';

final List<Expense> expenses = [
  Expense('Movie', 2000.0, DateTime.now(), Category.leisure),
  Expense('Flutter course', 500.0, DateTime.now(), Category.work)
];
var categoryIcon = {
  Category.food: Icons.dining_outlined,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_rounded,
  Category.work: Icons.work
};

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    var ind = expenses.indexOf(expense);
    setState(() {
      expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Item deleted'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              setState(() {
                expenses.insert(ind, expense);
              });
            })));
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Expenses'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) {
                      return OpenForm(addExpense);
                    });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: expenses),
          Expanded(
              child: (expenses.isEmpty == true)
                  ? Center(child: Text('No expenses detected.'))
                  : ExpenseList(expenses, removeExpense)),
        ],
      ),
    );
  }
}
