import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class transactionItem extends StatefulWidget {
  final Transaction tr;
  final void Function(String) onRemove; // Não estava no meeu código

  // Construtor
  const transactionItem({
    Key? key,
    required this.tr,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<transactionItem> createState() => _transactionItemState();
}

class _transactionItemState extends State<transactionItem> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];

  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();

    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
  }

  // Janela Modal para confirmar se pretendemos apagar
  bool? showConfirmation(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir'),
        content: const Text('Tem certeza?'),
        actions: [
          FlatButton(
            textColor: Theme.of(context).errorColor,
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Não'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            textColor: Colors.green,
            child: const Text('Sim'),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed) {
        widget.onRemove(id);
      }
    });
  }

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
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('R\$${widget.tr.value}'),
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(DateFormat('d MMM y').format(widget.tr.date)),
        trailing: MediaQuery.of(context).size.width > 480
            ? FlatButton.icon(
                onPressed: () {
                  showConfirmation(context, widget.tr.id);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Excluir'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                onPressed: () {
                  showConfirmation(context, widget.tr.id);
                },
                color: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete),
              ),
      ),
    );
  }
}
