import 'package:flutter/material.dart';

import '../../models/sale.dart';
import 'new_sale_screen.dart';
import 'sale_details_screen.dart';

class SalesListScreen extends StatefulWidget {
  const SalesListScreen({super.key});

  @override
  State<SalesListScreen> createState() => _SalesListScreenState();
}

class _SalesListScreenState extends State<SalesListScreen> {
  final List<Sale> sales = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales History"),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_shopping_cart),
        onPressed: () async {
          final Sale? newSale = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const NewSaleScreen(),
            ),
          );

          if (!mounted) return;

          if (newSale != null) {
            setState(() {
              sales.add(newSale);
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Sale Added Successfully"),
              ),
            );
          }
        },
      ),

      body: sales.isEmpty
          ? const Center(
              child: Text(
                "No Sales Yet",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: sales.length,
              itemBuilder: (context, index) {
                final sale = sales[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SaleDetailsScreen(
                            sale: sale,
                          ),
                        ),
                      );
                    },

                    leading: const CircleAvatar(
                      child: Icon(Icons.shopping_cart),
                    ),

                    title: Text(
                      sale.customerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      "${sale.productName}\nQty: ${sale.quantity}",
                    ),

                    trailing: Text(
                      "Rs ${sale.total.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}