import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withValues(alpha: 0.15),
              child: Icon(
                icon,
                color: color,
                size: 26,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryCardSection extends StatelessWidget {
  const SummaryCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Row(
          children: [
            Expanded(
              child: SummaryCard(
                title: "Sales",
                value: "Rs. 25,000",
                icon: Icons.attach_money,
                color: Colors.green,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: SummaryCard(
                title: "Products",
                value: "120",
                icon: Icons.inventory_2_outlined,
                color: Colors.orange,
              ),
            ),
          ],
        ),

        SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: SummaryCard(
                title: "Customers",
                value: "45",
                icon: Icons.people_outline,
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: SummaryCard(
                title: "Suppliers",
                value: "18",
                icon: Icons.local_shipping_outlined,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}