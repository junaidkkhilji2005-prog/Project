class Sale {
  String id;
  String customerName;
  String productName;
  int quantity;
  double price;
  double total;
  DateTime date;

  Sale({
    required this.id,
    required this.customerName,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.total,
    required this.date,
  });
}