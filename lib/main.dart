import 'package:expenses/components/chart.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  final ThemeData tema = ThemeData();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
          // primaryColor: Colors.purple,
          // secondaryHeaderColor: Colors.amber,
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.amber,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.deepPurple,
            textTheme: ButtonTextTheme.accent,
            colorScheme:
                Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
          ),
          textTheme: tema.textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              titleSmall: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              titleMedium: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 15,
                color: Colors.black,
              )),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: const Text(
            'Despesas Pessoais',
            textAlign: TextAlign.start,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: const Icon(Icons.add),
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
