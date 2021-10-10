import 'dart:math';

import 'package:flutter/material.dart';
import '../modals/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  final colors = [Colors.blue, Colors.black, Colors.red];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colors[Random().nextInt(3)],
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(child: Text('\$${transaction.amount}')),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                onPressed: () => deleteTransaction(transaction.id),
                textColor: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
              )
            : IconButton(
                onPressed: () => deleteTransaction(transaction.id),
                icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
              ),
      ),
    );
  }
}
