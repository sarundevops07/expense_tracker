import 'package:expense_tracker/model/expence.dart';
import 'package:expense_tracker/presentation/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expense, required this.onRemoveExpense});
  final List<Expense> expense;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.onErrorContainer,
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (_) {
          onRemoveExpense(expense[index]);
        },
        key: ValueKey(expense[index]),
        child: ExpenseItem(expense: expense[index]),
      ),
    );
  }
}
