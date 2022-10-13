import 'package:flutter/material.dart';
import '../../models/transaction.dart';
import '../novo/transaction_item_new.dart';

class TransactionList extends StatelessWidget {
  // Atributos
  final List<Transaction> transactions;
  // Atributo - função
  final void Function(String) onRemove;

  // Construtor
  TransactionList(this.transactions, this.onRemove);



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
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return transactionItem(
                tr: tr,
                onRemove: onRemove,
              );
            },
          );
  }
}
