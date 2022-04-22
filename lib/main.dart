import 'package:personal_expense_app/widgets/New_transaction.dart';
import 'package:personal_expense_app/widgets/Transactions_list.dart';
import 'package:personal_expense_app/widgets/chart.dart';

import 'models/transactions.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_app/widgets/User_Transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme:ThemeData.light().textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          button: TextStyle(color: Colors.white),
        ) ,
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> usertransactions = [
  /*  Transaction(
        id: 't1', title: 'new phone', amount: 899.99, date: DateTime.now()),
    Transaction(id: 't2', title: 'Revo', amount: 3899.99, date: DateTime.now())*/
  ];

  List<Transaction> get _recentTransactions {
    return usertransactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),
      ));

    }).toList()  ;
  }


  void _addNewTransaction(String txTitle, double txAmount , DateTime _selectedDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: _selectedDate,
    );
    setState(() {
      usertransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(child: NewTransaction(_addNewTransaction),
          onTap: (){},
          behavior: HitTestBehavior.opaque,);
        });
  }
    void _deleteTransaction(String id){
     setState(() {
       usertransactions.removeWhere((element) =>  element.id ==id);
     });
    }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Expense APP'),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: const Icon(
                Icons.add,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Chart(usertransactions),
            Transactions_list(usertransactions , _deleteTransaction ),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
        //backgroundColor: Colors.lightGreen,
      ),
    );
  }
}
