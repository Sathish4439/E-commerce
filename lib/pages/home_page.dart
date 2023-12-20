// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newrestapp/component/product.dart';
import 'package:newrestapp/component/productshow.dart';

import 'package:newrestapp/pages/cart_page.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../component/productprovider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List productlist = [];

  getproduct() async {
    String url = 'https://fakestoreapi.com/products';

    var res = await http.get(Uri.parse(url));

    setState(() {
      if (res.statusCode == 200) {
        productlist = jsonDecode(res.body);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getproduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Productprovider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              const DrawerHeader(
                child: Icon(
                  Icons.person,
                  size: 100,
                ),
              ),
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        leading: const Icon(Icons.home),
                        title: const Text("Home"),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartPage()));
                        },
                        leading: const Icon(Icons.shopping_cart),
                        title: Text("Orders"),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        leading: Icon(Icons.rate_review),
                        title: Text("Rateing"),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        leading: Icon(Icons.contact_emergency),
                        title: Text("Contact"),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        leading: Icon(Icons.info_outline),
                        title: Text("About us"),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Logout"),
                  ),
                ],
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("Shoping page"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartPage()));
                },
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: productlist.length,
              itemBuilder: ((context, index) {
                return Productshow(
                    onTap: () {
                      String scr = productlist[index]["image"];
                      var item = product(
                          child: scr,
                          name: productlist[index]["title"],
                          price: productlist[index]["price"].toString());
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
                                title: Text("Successfully added to cart"),
                              ));

                      Productprovider.addToCart(item);
                      //  Navigator.pop(context);
                    },
                    count: productlist[index]["rating"]["count"],
                    rating: productlist[index]["rating"]["rate"],
                    image: productlist[index]["image"],
                    title: productlist[index]["title"]);
              })),
        ));
  }
}