import 'package:flutter/material.dart';

import '../../models/sale.dart';

class NewSaleScreen extends StatefulWidget {
  const NewSaleScreen({super.key});

  @override
  State<NewSaleScreen> createState() => _NewSaleScreenState();
}

class _NewSaleScreenState extends State<NewSaleScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<String> customers = [
    "Ali Khan",
    "Ahmed",
    "Sara",
  ];

  final Map<String, double> products = {
    "Laptop": 85000,
    "Keyboard": 2500,
    "Mouse": 1200,
    "Monitor": 30000,
  };

  String? selectedCustomer;
  String? selectedProduct;

  final TextEditingController quantityController =
      TextEditingController();

  double total = 0;

  void calculateTotal() {
    if (selectedProduct == null) return;

    final qty =
        int.tryParse(quantityController.text) ?? 0;

    final price = products[selectedProduct] ?? 0;

    setState(() {
      total = qty * price;
    });
  }

  void saveSale() {
    if (!_formKey.currentState!.validate()) return;

    final qty = int.parse(quantityController.text);

    final price = products[selectedProduct]!;

    final sale = Sale(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      customerName: selectedCustomer!,
      productName: selectedProduct!,
      quantity: qty,
      price: price,
      total: total,
      date: DateTime.now(),
    );

    Navigator.pop(context, sale);
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Sale"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              DropdownButtonFormField<String>(
                initialValue: selectedCustomer,
                decoration: const InputDecoration(
                  labelText: "Customer",
                  prefixIcon: Icon(Icons.person),
                ),
                items: customers.map((customer) {
                  return DropdownMenuItem(
                    value: customer,
                    child: Text(customer),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCustomer = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Select Customer";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                initialValue: selectedProduct,
                decoration: const InputDecoration(
                  labelText: "Product",
                  prefixIcon: Icon(Icons.inventory),
                ),
                items: products.keys.map((product) {
                  return DropdownMenuItem(
                    value: product,
                    child: Text(product),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedProduct = value;
                  });
                  calculateTotal();
                },
                validator: (value) {
                  if (value == null) {
                    return "Select Product";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Quantity",
                  prefixIcon: Icon(Icons.numbers),
                ),
                onChanged: (_) => calculateTotal(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Quantity";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.payments,
                    color: Colors.green,
                  ),
                  title: const Text("Total Amount"),
                  subtitle: Text(
                    "Rs ${total.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: saveSale,
                  icon: const Icon(Icons.save),
                  label: const Text("Save Sale"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}