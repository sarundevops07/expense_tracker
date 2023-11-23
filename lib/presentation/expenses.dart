import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: const [Icon(Icons.add)],
      ),
      body: ListView.builder(itemBuilder: (ctx, index) {
        return const Placeholder();
      }),
    );
  }
}
