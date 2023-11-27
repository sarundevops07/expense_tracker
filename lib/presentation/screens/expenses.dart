import 'package:expense_tracker/model/expence.dart';
import 'package:expense_tracker/presentation/widgets/chart/chart.dart';
import 'package:expense_tracker/presentation/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/presentation/widgets/new_expenses.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        amount: 500,
        title: 'Flutter course',
        date: DateTime.now(),
        category: Category.work),
    Expense(
        amount: 100,
        title: 'fun',
        date: DateTime.now(),
        category: Category.travel),
    Expense(
        amount: 700,
        title: 'lunch',
        date: DateTime.now(),
        category: Category.food)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        constraints: const BoxConstraints(),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return NewExpense(
            onAddExpense: _addExpense,
          );
        });
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          onPressed: () => setState(() {
            _registeredExpenses.insert(
              expenseIndex,
              expense,
            );
          }),
          label: 'Undo',
        ),
        content: const Text('Expense deleted'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(child: Text('No expense found'));
    if (_registeredExpenses.isNotEmpty) {
      setState(() {
        mainContent = ExpensesList(
          expense: _registeredExpenses,
          onRemoveExpense: _removeExpense,
        );
      });
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _openAddExpenseOverlay,
            )
          ],
        ),
        body: screenWidth < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(child: mainContent)
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(child: mainContent)
                ],
              ));
  }
}
