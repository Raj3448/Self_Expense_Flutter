import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfirstapp/model/Transaction.dart';
import 'package:myfirstapp/widget/chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> currentTransactions;

  const Chart(this.currentTransactions);

  List<Map<String, Object>> get GroupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (int i = 0; i < currentTransactions.length; i++) {
        if (currentTransactions[i].date.day == weekDay.day &&
            currentTransactions[i].date.month == weekDay.month &&
            currentTransactions[i].date.year == weekDay.year) {
          totalSum += currentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalamount {
    return GroupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(GroupedTransactionValues);
    return Card(
      elevation: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...GroupedTransactionValues.map((element) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: element['day'] as String,
                  amount: element['amount'] as double,
                  spendingPersentage: totalamount == 0.0
                      ? 0.0
                      : (element['amount'] as double) / totalamount),
            );
          }).toList(),
        ],
      ),
    );
  }
}
