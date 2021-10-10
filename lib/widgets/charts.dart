import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/widgets/chart_bar.dart';
import '../modals/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));

      double amount = 0.0;

      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          amount += transactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': amount
      };
    }).reversed.toList();
  }

  double get totalSum {
    return groupedTransactionsValues.fold(0.0, (sum, element) {
      return sum += element['amount'] as double;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 116,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionsValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: Bar(data['amount'] as double, data['day'],
                  totalSum > 0 ? (data['amount'] as double) / totalSum : 0),
            );
          }).toList(),
        ),
      ),
    );
  }
}
