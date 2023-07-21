import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class ExpenseCard extends StatelessWidget{
  const ExpenseCard(this.data, {super.key});
  final Expense data;
  @override
  Widget build(context)
  {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.title, style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(height:15),
            Row(
              children:[
                Text('Rs. ${data.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children:[
                    Icon(categoryIcon[data.category]),
                    const SizedBox(width:15),
                    Text(data.Format())
                  ]
                )


              ]
            )

          ]
        ),
      )
    );
  }

}