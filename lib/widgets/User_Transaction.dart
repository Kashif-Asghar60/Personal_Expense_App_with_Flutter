import 'package:flutter/cupertino.dart';
import 'New_transaction.dart';
import 'package:personal_expense_app/models/transactions.dart';
import 'Transactions_list.dart';
class UserTransaction extends StatefulWidget {
  const UserTransaction({Key? key}) : super(key: key);

  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> usertransactions = [
    Transaction(
        id: 't1', title: 'new phone', amount: 899.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'Revo', amount: 3899.99, date: DateTime.now())
  ];

  void _addNewTransaction(String txTitle , double txAmount){
    final newTx= Transaction(id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());
setState(() {
  usertransactions.add(newTx);
});
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
   // Transactions_list(usertransactions ,delet),
      ],
    );
  }
}
