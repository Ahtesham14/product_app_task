// product_provider.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_app/models/product_model.dart';
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts([bool sortDescending = false]) async {
    _isLoading = true;
    notifyListeners();

    final url = sortDescending
        ? 'https://fakestoreapi.com/products?sort=desc'
        : 'https://fakestoreapi.com/products';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _products = data.map((item) => Product.fromJson(item)).toList();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Product?> fetchProductById(int id) async {
    final url = 'https://fakestoreapi.com/products/$id';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Product.fromJson(data);
    }
    return null;
  }
}
