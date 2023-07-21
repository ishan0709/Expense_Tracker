import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
enum Category {work,food,travel,leisure}
const uuid =Uuid();
final formatter = DateFormat.yMd();
class Expense {
  Expense(this.title, this.amount, this.date, this.category) : id= uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String Format() {
    return formatter.format(date);
  }
}
  class ExpenseBucket{
    ExpenseBucket(this.expenses, this.category);
    ExpenseBucket.forCategory(List<Expense> allExpenses, this.category): expenses = allExpenses.where((expense) => expense.category==category).toList();
    List<Expense> expenses;
    Category category;
  double get TotalExpenses{
    double sum=0;
    for(final expense in expenses){
      sum+=expense.amount;
    }

    return sum;
  }

  }

