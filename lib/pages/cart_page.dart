import 'package:flutter/material.dart';
import 'package:newrestapp/component/productprovider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cart Page"),
        ),
        body: Consumer<ProductProvider>(
            builder: (context, productprovider, child) {
          final item = productprovider.Products;
          return ListView.builder(
              itemCount: item.length,
              itemBuilder: (context, index) {
                final products = item[index];
                return ListTile(
                  leading: Image.network(products.child),
                  title: Text(products.name),
                  subtitle: Text("Price : " + products.price),
                  trailing: IconButton(
                      onPressed: () {
                        productprovider.removefromCart(products);
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Done"))
                                  ],
                                  title: Text("Item removed from cart"),
                                ));
                      },
                      icon: const Icon(Icons.delete)),
                );
              });
        }));
  }
}
