import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../models/transaction.dart';



class transactionItem extends StatelessWidget {
  final Transaction tr;
  final void Function(String) onRemove; // Não estava no meeu código

  // Construtor
  const transactionItem({
    Key? key,
    required this.tr,
    required this.onRemove,
  }) : super(key: key);


  // Janela Modal para confirmar se pretendemos apagar
  // Verificar se funciona em IOS
  // Queria tirar BuildContext context
  // também podia tirar o "Future/Promisse"
  bool? showConfirmation(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir'),
        content: const Text('Tem certeza?'),
        actions: [
          FlatButton(
            child: const Text('Não'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: const Text('Sim'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed) {
        onRemove(id);
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
          backgroundColor: Colors.purple,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('R\$${tr.value}'),
            ),
          ),
        ),
        title: Text(
          tr.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(DateFormat('d MMM y').format(tr.date)),
        trailing: MediaQuery.of(context).size.width > 480
            ? FlatButton.icon(
                onPressed: () {
                  showConfirmation(context, tr.id);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Excluir'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                onPressed: () {
                  showConfirmation(context, tr.id);
                },
                color: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete),
              ),
      ),
    );
  }
}
