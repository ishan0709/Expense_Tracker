import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/expenses.dart';

class OpenForm extends StatefulWidget {
  OpenForm(this.addExpense,{super.key});
  void Function(Expense) addExpense;
  @override
  State<OpenForm> createState() {
    return _OpenFormState();
  }
}
Category selectedCategory= Category.work;
DateTime? selectedDate;

class _OpenFormState extends State<OpenForm> {
  void pickDate() async {
    DateTime cd = DateTime.now();
    DateTime fd = DateTime(cd.year - 1, cd.month, cd.day);

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: fd,
        lastDate: DateTime.now());
    setState(() {
      selectedDate = pickedDate;
    });
  }

  var inputTitle = TextEditingController();
  var inputAmount = TextEditingController();
  @override
  void dispose() {
    inputTitle.dispose();
    inputAmount.dispose();
    super.dispose();
  }

  void validateData(){
    var inputAmt= double.tryParse(inputAmount.text);
    var v=inputTitle.text.trim()==null? true: false;
    if(v||inputAmt==null||inputAmt<0||selectedDate==null)
      {
        showDialog(context: context, builder: (ctx)=> AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please enter valid data.'),
          actions: [
            TextButton(onPressed: (){ Navigator.pop(context);}, child: Text('Ok'))
          ],
        )
        );
        return;
      }
   widget.addExpense(Expense(inputTitle.text,inputAmt,selectedDate!,selectedCategory));
    Navigator.pop(context);


  }


  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Column(children: [
        TextField(
          decoration: const InputDecoration(
            label: Text('Title'),
          ),
          controller: inputTitle,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  label: Text('Amount'),
                ),
                keyboardType: TextInputType.number,
                controller: inputAmount,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(selectedDate!)),
                    IconButton(
                        onPressed: pickDate,
                        icon: const Icon(Icons.calendar_month))
                  ]),
            )
          ],
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              DropdownButton(
                value: selectedCategory,
                  items: Category.values
                      .map((category) =>
                          DropdownMenuItem(
                              value:category,
                              child: Text(category.name.toUpperCase())),
    )
                      .toList(),
                  onChanged: (value) {
                    setState((){
    selectedCategory= value!;
    });
                    }

                  ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: ElevatedButton(
                    onPressed: () {
                      validateData();
                    }, child: const Text('Save'),
                ),
              ),
              //const SizedBox(width: 50),
              Padding(
                padding: EdgeInsets.fromLTRB(2.0,0,0,0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
