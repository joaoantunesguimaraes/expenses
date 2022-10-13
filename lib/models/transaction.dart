class Transaction {
  // Atributos
  final String id;
  final String title;
  final double value;
  final DateTime date;

  // construtor com atributos nomeados
  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });
}
