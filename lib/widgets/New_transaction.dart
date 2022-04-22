import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final  Function addtx;

          NewTransaction(this.addtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController= TextEditingController();
  final _amountController= TextEditingController();
  DateTime ? _selectedDate;


 void submitData(){
    if(_amountController.text.isEmpty){
      return;
    }
   final Enteredtext=_titleController.text;
   final EnteredAmount= double.parse(_amountController.text);
   if(Enteredtext.isEmpty || EnteredAmount<=0 || _selectedDate==null){
     return;
   }
   widget.addtx(
       Enteredtext,
       EnteredAmount,
     _selectedDate
      );
   Navigator.pop(context);
 }
  void _presentDatePicker(){
   showDatePicker(context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime(2019),
       lastDate: DateTime.now(),).then((pickedDate){
         if(pickedDate==null){
           return;
         }
         setState(() {
           _selectedDate = pickedDate;
         });

   });
   print('...');
  }
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_)=> submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(),
                onSubmitted: (_)=> submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(_selectedDate== null
                        ? 'No Date Chosen!'
                        :'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                    FlatButton(onPressed: () {
                      _presentDatePicker();
                    },
                        textColor: Theme.of(context).primaryColor,
                    child: const Text(
                      'Chosen Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: submitData,
                // (){ print(titleController.text)};
                child: const Text('Add Transaction',),
                textColor: Theme.of(context).textTheme.button!.color,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ))
    ;
  }
}
