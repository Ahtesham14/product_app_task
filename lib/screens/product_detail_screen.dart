// product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:product_app/models/product_model.dart';
import 'package:product_app/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  ProductDetailScreen(this.productId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: FutureBuilder<Product?>(
        future: Provider.of<ProductProvider>(context, listen: false)
            .fetchProductById(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading product'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Product not found'));
          } else {
            final product = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(product.image),
                    SizedBox(height: 16),
                    Text(product.title,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('\$${product.price}', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 16),
                    Text(product.description),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
