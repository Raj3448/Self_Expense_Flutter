import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:intl/intl.dart';
import 'package:myfirstapp/model/Transaction.dart';
import './transactionItem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> usertransaction;
  final Function deleteTx;
  const TransactionList(this.usertransaction, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return usertransaction.isEmpty
        ? LayoutBuilder(builder: (context, Constraints) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    'Empty Transactions',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    selectionColor: Color.fromARGB(255, 69, 68, 68),
                  ),
                ),
                Container(
                    height: Constraints.maxHeight * 0.7,
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                        'windows/InsertingEvent/Images/No transaction.png')),
              ],
            );
          })
        : ListView.builder(
            itemCount: usertransaction.length,
            itemBuilder: (context, index) {
              return TransactionItem(
                  usertransaction: usertransaction[index], deleteTx: deleteTx);
            },
          );
  }
}
