import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  var _selectedDate = null;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }

    var enteredTitle = titleController.text;
    var enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(
      titleController.text,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((PickedDate) {
      setState(() {
        _selectedDate = PickedDate;
      });
    });
  }

  List<Widget> _getDatePickerAndButton() {
    return [
      Container(
        height: 70,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(_selectedDate == null
                  ? "No date choosen!"
                  : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}"),
            ),
            FlatButton(
              onPressed: _presentDatePicker,
              child: Text(
                "Choose Date",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      RaisedButton(
        onPressed: submitData,
        textColor: Theme.of(context).textTheme.button!.color,
        color: Theme.of(context).primaryColor,
        child: Text('Add Transaction'),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => submitData(),
              ),
              ..._getDatePickerAndButton(),
            ],
          ),
        ),
      ),
    );
  }
}
