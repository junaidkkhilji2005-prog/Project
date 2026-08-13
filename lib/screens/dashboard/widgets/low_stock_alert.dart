import 'package:flutter/material.dart';

class LowStockAlert extends StatelessWidget {
  const LowStockAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final lowStockProducts = [
      {"name": "Laptop", "stock": 2},
      {"name": "Mouse", "stock": 3},
      {"name": "Keyboard", "stock": 1},
    ];

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                ),
                SizedBox(width: 8),
                Text(
                  "Low Stock Alerts",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            ...lowStockProducts.map(
              (product) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.inventory_2,
                    color: Colors.white,
                  ),
                ),
                title: Text(product["name"].toString()),
                subtitle: Text(
                  "Only ${product["stock"]} left",
                ),
                trailing: const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}