import 'dart:math';

import 'package:flutter/material.dart';
import '../model/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    required this.usertransaction,
    required this.deleteTx,
  });

  final Transaction usertransaction;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _BckColor = Colors.black;

  @override
  void initState() {
    const availableColors = [
      Colors.blue,
      Colors.cyan,
      Colors.green,
      Colors.orange,
      Colors.pink,
    ];

    _BckColor = availableColors[Random().nextInt(5)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return SingleChildScrollView(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundColor: _BckColor,
                    radius: 40,
                    child: FittedBox(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '₹' +
                              widget.usertransaction.amount.toStringAsFixed(2),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: constraints.maxWidth * 0.05),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FittedBox(
                        child: Text(
                          widget.usertransaction.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        DateFormat.yMMMEd().format(widget.usertransaction.date),
                        style: TextStyle(
                          color: Color.fromARGB(255, 59, 58, 58),
                        ),
                      ),
                    ],
                  ),
                ),
                if (constraints.maxWidth >= 600) Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: FittedBox(
                    child: IconButton(
                      onPressed: () =>
                          widget.deleteTx(widget.usertransaction.id),
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
