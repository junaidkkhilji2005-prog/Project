import 'package:flutter/material.dart';

import '../../models/customer.dart';
import 'add_customer_screen.dart';
import 'edit_customer_screen.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final List<Customer> customers = [
    Customer(
      id: "1",
      name: "Ali Khan",
      phone: "03001234567",
      email: "ali@gmail.com",
      address: "Quetta",
    ),
    Customer(
      id: "2",
      name: "Ahmed",
      phone: "03111234567",
      email: "ahmed@gmail.com",
      address: "Karachi",
    ),
  ];

  List<Customer> filteredCustomers = [];

  @override
  void initState() {
    super.initState();
    filteredCustomers = List.from(customers);
  }

  void searchCustomer(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        filteredCustomers = List.from(customers);
      } else {
        filteredCustomers = customers.where((customer) {
          return customer.name
              .toLowerCase()
              .contains(keyword.toLowerCase());
        }).toList();
      }
    });
  }

  void deleteCustomer(Customer customer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Customer"),
          content: Text(
            "Are you sure you want to delete '${customer.name}'?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  customers.remove(customer);
                  filteredCustomers.remove(customer);
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Customer Deleted"),
                  ),
                );
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Future<void> editCustomer(Customer customer) async {
    final Customer? updatedCustomer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditCustomerScreen(
          customer: customer,
        ),
      ),
    );

    if (!mounted) return;

    if (updatedCustomer != null) {
      setState(() {
        filteredCustomers = List.from(customers);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Customer Updated Successfully"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customers"),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () async {
          final Customer? newCustomer = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddCustomerScreen(),
            ),
          );

          if (!mounted) return;

          if (newCustomer != null) {
            setState(() {
              customers.add(newCustomer);
              filteredCustomers = List.from(customers);
            });
          }
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Search Customer...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: searchCustomer,
            ),

            const SizedBox(height: 15),

            Expanded(
              child: filteredCustomers.isEmpty
                  ? const Center(
                      child: Text(
                        "No Customers Found",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredCustomers.length,
                      itemBuilder: (context, index) {
                        final customer = filteredCustomers[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                customer.name[0].toUpperCase(),
                              ),
                            ),

                            title: Text(
                              customer.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            subtitle: Text(
                              "${customer.phone}\n${customer.email}",
                            ),

                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    editCustomer(customer);
                                  },
                                ),

                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    deleteCustomer(customer);
                                  },
                                ),
                              ],
                            ),

                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}