import 'package:flutter/material.dart';
import 'package:third_app/widgets/chart.dart';
import 'package:third_app/widgets/new_transaction.dart';
import 'package:third_app/widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.greenAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late String titleInput;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final List<Transaction> _userTransactions = [
    
  ];
List<Transaction> get _recentTransactions{

  return _userTransactions.where((tx) {
    return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),));
  }).toList();
}

  void _addNewTransaction(String txtitle, double txamount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txtitle,
        amount: txamount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransatcion(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransatcion(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }
 void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx){
        return tx.id==id;
      });
    });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransatcion(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            // UserTransactions(),
             TransactionList(_userTransactions,_deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransatcion(context),
      ),
    );
  }
}
