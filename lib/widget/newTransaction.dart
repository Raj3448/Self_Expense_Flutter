import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTx;

  NewTransaction({required this.addNewTx});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  var selectedDate;

  void dataSubmit() {
    if (titleController.text.isEmpty ||
        double.parse(amountController.text) <= 0 ||
        selectedDate == null) {
      return;
    }
    widget.addNewTx(
      titleController.text,
      double.parse(amountController.text),
      selectedDate,
    );
    Navigator.of(context).pop();
  }

  void dateSelection() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((enteredDate) {
      if (enteredDate == null) {
        return;
      } else {
        setState(() {
          selectedDate = enteredDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 15,
        child: Container(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
                cursorColor: Colors.pink,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.pink,
                // onChanged: (val) => amountInput = val,
              ),
              Container(
                height: 70,
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(selectedDate == null
                          ? 'No date selected yet!'
                          : 'Selected Date : ' +
                              DateFormat.yMEd()
                                  .format(selectedDate)
                                  .toString()),
                    ),
                    TextButton(
                        //style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.indigo)),
                        onPressed: () => dateSelection(),
                        child: const Text(
                          'Select Date',
                          style: TextStyle(color: Colors.purple),
                        )),
                  ],
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 2, color: Colors.pink)),
                onPressed: () => dataSubmit(),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.pink, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
