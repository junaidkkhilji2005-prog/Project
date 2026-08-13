import 'package:flutter/material.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        "title": "Sale Completed",
        "subtitle": "Invoice #1001",
        "icon": Icons.point_of_sale,
        "time": "Today",
      },
      {
        "title": "Product Added",
        "subtitle": "Wireless Mouse",
        "icon": Icons.inventory_2_outlined,
        "time": "Yesterday",
      },
      {
        "title": "Customer Added",
        "subtitle": "Ali Khan",
        "icon": Icons.person_add_alt_1,
        "time": "2 days ago",
      },
      {
        "title": "Supplier Updated",
        "subtitle": "ABC Traders",
        "icon": Icons.local_shipping_outlined,
        "time": "3 days ago",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Activity",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Card(
          elevation: 2,
          child: ListView.separated(
            itemCount: activities.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
  return const Divider(height: 1);
},
            itemBuilder: (context, index) {
              final item = activities[index];

              return ListTile(
                leading: CircleAvatar(
                  child: Icon(item["icon"] as IconData),
                ),
                title: Text(item["title"] as String),
                subtitle: Text(item["subtitle"] as String),
                trailing: Text(
                  item["time"] as String,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}