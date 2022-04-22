import 'package:flutter/material.dart';
import 'package:personal_expense_app/models/transactions.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/widgets/chartBar.dart';
class Chart extends StatelessWidget {


  final List<Transaction>recentTransactions;
 Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactionsValues{
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum=0.0;
      for(var i=0; i< recentTransactions.length;i++){
        if(recentTransactions[i].date.day==weekDay.day &&
        recentTransactions[i].date.month== weekDay.month &&
        recentTransactions[i].date.year==weekDay.year){
          totalSum += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay).substring(0,1));
      print(totalSum);
       return{
        'day': DateFormat.E().format(weekDay),
         'amount': totalSum,
       };

    }
    ).reversed.toList();

  }
  double get totalSpending{
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double );
    });
  }
  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsValues);
    return Container(
      padding: EdgeInsets.all(10),
      child: Flexible(
        fit: FlexFit.tight,
        child: Card(
          elevation: 6,
            margin: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionsValues.map((data){
              return ChartBar((data['day'] as String).substring(0,1),(data['amount'] as double),totalSpending ==0.0 ? 0.0 : (data['amount']as double)/totalSpending);
            }).toList(),

              ),
        ),
      ),
    );
  }
}
