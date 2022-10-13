import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  // Atributos
  final List<Transaction> transactions;
  // Atributo - função
  final void Function(String) onRemove;

  // Construtor
  const TransactionList(this.transactions, this.onRemove, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: ((context, constraints) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Nenhuma Transação Registada!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 20),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/fonts/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          }))
        // : ListView.builder(
        //     itemCount: transactions.length,
        //     itemBuilder: (ctx, index) {
        //       final tr = transactions[index];
        //       return transactionItem(
        //         key: GlobalObjectKey(tr.id),
        //         tr: tr,
        //         onRemove: onRemove,
        //       );
        //     },
        //   );

        : ListView(
          children: transactions.map((tr) { 
            return transactionItem(
            key: ValueKey(tr.id),
            tr: tr,
            onRemove: onRemove,
           );
           }).toList(),
          );

  }
}
