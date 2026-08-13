import 'package:flutter/material.dart';

class DashboardStats extends StatelessWidget {
  final int totalProducts;
  final int totalCustomers;
  final int totalSales;
  final double totalRevenue;

  const DashboardStats({
    super.key,
    required this.totalProducts,
    required this.totalCustomers,
    required this.totalSales,
    required this.totalRevenue,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: [
        _buildCard(
          "Products",
          totalProducts.toString(),
          Icons.inventory_2,
          Colors.blue,
        ),
        _buildCard(
          "Customers",
          totalCustomers.toString(),
          Icons.people,
          Colors.green,
        ),
        _buildCard(
          "Sales",
          totalSales.toString(),
          Icons.shopping_cart,
          Colors.orange,
        ),
        _buildCard(
          "Revenue",
          "Rs ${totalRevenue.toStringAsFixed(0)}",
          Icons.attach_money,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 34),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(title),
          ],
        ),
      ),
    );
  }
}