import 'package:flutter/material.dart';
import '../../models/product.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({
    super.key,
    required this.product,
  });

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController priceController;
  late TextEditingController stockController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.product.name);
    categoryController = TextEditingController(text: widget.product.category);
    priceController =
        TextEditingController(text: widget.product.price.toString());
    stockController =
        TextEditingController(text: widget.product.stock.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    priceController.dispose();
    stockController.dispose();
    super.dispose();
  }

  void updateProduct() {
    if (_formKey.currentState!.validate()) {
      widget.product.name = nameController.text;
      widget.product.category = categoryController.text;
      widget.product.price = double.parse(priceController.text);
      widget.product.stock = int.parse(stockController.text);

      Navigator.pop(context, widget.product);
    }
  }

  InputDecoration customDecoration({
    required String label,
    required IconData icon,
    String? prefix,
  }) {
    return InputDecoration(
      labelText: label,
      prefixText: prefix,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: Colors.indigo,
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Edit Product",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo,
                Colors.blue,
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              const CircleAvatar(
                radius: 45,
                backgroundColor: Colors.indigo,
                child: Icon(
                  Icons.edit_note,
                  color: Colors.white,
                  size: 42,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Update Product",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Modify your product information",
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 30),

              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    children: [

                      TextFormField(
                        controller: nameController,
                        decoration: customDecoration(
                          label: "Product Name",
                          icon: Icons.shopping_bag_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter product name";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: categoryController,
                        decoration: customDecoration(
                          label: "Category",
                          icon: Icons.category_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter category";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: priceController,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        decoration: customDecoration(
                          label: "Price",
                          icon: Icons.attach_money,
                          prefix: "\$ ",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter price";
                          }

                          if (double.tryParse(value) == null) {
                            return "Enter a valid price";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: stockController,
                        keyboardType: TextInputType.number,
                        decoration: customDecoration(
                          label: "Stock Quantity",
                          icon: Icons.inventory_2_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter stock";
                          }

                          if (int.tryParse(value) == null) {
                            return "Enter a valid quantity";
                          }

                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: updateProduct,
                  icon: const Icon(Icons.system_update_alt),
                  label: const Text(
                    "Update Product",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "Changes will be saved immediately.",
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}