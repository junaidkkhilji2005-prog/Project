import 'package:flutter/material.dart';

import '../../models/product.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Product> products = [
    Product(
      id: "1",
      name: "Laptop",
      category: "Electronics",
      price: 85000,
      stock: 12,
    ),
    Product(
      id: "2",
      name: "Keyboard",
      category: "Accessories",
      price: 2500,
      stock: 30,
    ),
  ];

  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = List.from(products);
  }

  void searchProducts(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        filteredProducts = List.from(products);
      } else {
        filteredProducts = products.where((product) {
          return product.name
              .toLowerCase()
              .contains(keyword.toLowerCase());
        }).toList();
      }
    });
  }

  void deleteProduct(Product product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Product"),
          content: Text(
            "Are you sure you want to delete '${product.name}'?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  products.remove(product);
                  filteredProducts.remove(product);
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Product Deleted"),
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

  Future<void> editProduct(Product product) async {
    final Product? updatedProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProductScreen(product: product),
      ),
    );

    if (updatedProduct != null) {
      setState(() {
        filteredProducts = List.from(products);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product Updated Successfully"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final Product? newProduct = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddProductScreen(),
            ),
          );

          if (newProduct != null) {
            setState(() {
              products.add(newProduct);
              filteredProducts = List.from(products);
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
                hintText: "Search Product...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: searchProducts,
            ),

            const SizedBox(height: 15),

            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(
                      child: Text(
                        "No Products Found",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          elevation: 2,
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.inventory_2),
                            ),

                            title: Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            subtitle: Text(
                              "${product.category}\nStock: ${product.stock}",
                            ),

                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                Text(
                                  "Rs ${product.price.toStringAsFixed(0)}",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    editProduct(product);
                                  },
                                ),

                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    deleteProduct(product);
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