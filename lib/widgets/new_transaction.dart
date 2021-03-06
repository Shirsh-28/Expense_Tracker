import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransatcion extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);
  final Function addTx;

  NewTransatcion(this.addTx);

  @override
  State<NewTransatcion> createState() => _NewTransatcionState();
}

class _NewTransatcionState extends State<NewTransatcion> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate=DateTime.now() ;

  void _submitData() {
    if(_amountController.text.isEmpty){return;}
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate==null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presrntDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now()
        ).then((pickedDate) {
          if(pickedDate==null){
           // _selectedDate=DateTime.parse("");
            return;
          }
          setState(() {
            _selectedDate = pickedDate;
          });
          
        });
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
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title:'),
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount:'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              //onChanged: (val) => amountInput = val,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate==null
                    ? 'No Date Chosen!' 
                    :'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',),
                  ),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _presrntDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submitData,
              child: Text('Add Transaction'),
              color: Colors.purple,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
