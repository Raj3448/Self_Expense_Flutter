import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double spendingPersentage;
  const ChartBar(
      {required this.label,
      required this.amount,
      required this.spendingPersentage});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      return Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: [
            Container(height: Constraints.maxHeight * 0.15, child: Text(label)),
            Container(
              height: Constraints.maxHeight * 0.62,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 94, 91, 91), width: 1.5),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPersentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Constraints.maxHeight * 0.02,
            ),
            FittedBox(
                child: Container(
                    height: Constraints.maxHeight * 0.15,
                    child: Text('₹' + (amount.toString())))),
          ],
        ),
      );
    });
  }
}
