import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {

  final Transaction tr;
  final void Function(String id) onRemove;

  const TransactionItem({
    super.key,
    required this.tr,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                'R\$${tr.value}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          tr.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(tr.date),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () => onRemove(tr.id),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ),
                label: Text(
                  'Excluir',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              )
            : IconButton(
                icon: const Icon(
                  Icons.delete,
                ),
                onPressed: () => onRemove(tr.id),
                color: Theme.of(context).colorScheme.error,
              ),
      ),
    );
  }
}
