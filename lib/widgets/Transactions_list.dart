import 'package:flutter/material.dart';
import 'package:personal_expense_app/models/transactions.dart';
import 'package:intl/intl.dart';

class Transactions_list extends StatelessWidget {
/*
  */
  final List<Transaction> usertransactions;
  Function deleteTx;
  Transactions_list(this.usertransactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: usertransactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
               const SizedBox (
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset('assets/image/waiting.png'),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(

                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '\$${usertransactions[index].amount}'
                          ),
                        ),
                      ),
                    ),
                    title: Text(usertransactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(usertransactions[index].date),
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: ()=>   deleteTx(usertransactions[index].id)  ,
                    ),
                  ),
                );
              },
              itemCount: usertransactions.length,
            ),
    );
  }
}

/*
* Card(
                    child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        '\$${usertransactions[index].amount}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          usertransactions[index].title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          DateFormat.yMMMd()
                              .format(usertransactions[index].date),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    )
                  ],
                ));*/