import 'package:flutter/material.dart';
import 'package:newrestapp/component/product.dart';

class ProductProvider extends ChangeNotifier {
  List<product> _Products = [];

  List<product> get Products => _Products;

  void addToCart(product product) {
    Products.add(product);
    notifyListeners();
  }

  void removefromCart(product product) {
    Products.remove(product);
    notifyListeners();
  }
}
