import 'package:flutter/material.dart';

import '../../models/sale.dart';

class SaleDetailsScreen extends StatelessWidget {
  final Sale sale;

  const SaleDetailsScreen({
    super.key,
    required this.sale,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Center(
                  child: Icon(
                    Icons.receipt_long,
                    size: 60,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 20),

                buildRow("Customer", sale.customerName),
                buildRow("Product", sale.productName),
                buildRow("Quantity", sale.quantity.toString()),
                buildRow(
                  "Price",
                  "Rs ${sale.price.toStringAsFixed(0)}",
                ),
                buildRow(
                  "Total",
                  "Rs ${sale.total.toStringAsFixed(0)}",
                ),
                buildRow(
                  "Date",
                  sale.date.toString().split(" ").first,
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Print feature coming soon",
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.print),
                    label: const Text("Print Invoice"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}