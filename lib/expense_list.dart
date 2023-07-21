import 'package:expense_tracker/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/cupertino.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList(this.expenses, this.removeExpense, {super.key});
  List<Expense> expenses;
  void Function(Expense expense) removeExpense;
  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
            margin: Theme.of(context).cardTheme.margin),
            child: ExpenseCard(expenses[index]),
            key: ValueKey(expenses[index]),
            onDismissed: (direction){
            removeExpense(expenses[index]);

            },
          );
        });
  }
}
