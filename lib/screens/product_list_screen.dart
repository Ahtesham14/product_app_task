// product_list_screen.dart
import 'package:flutter/material.dart';
import 'package:product_app/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _isDescending = false;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon:
                Icon(_isDescending ? Icons.arrow_downward : Icons.arrow_upward),
            onPressed: () {
              setState(() {
                _isDescending = !_isDescending;
              });
              productProvider.fetchProducts(_isDescending);
            },
          ),
          Center(
            child: Text(_isDescending ? 'Descending' : 'Ascending'),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: productProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                final product = productProvider.products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product.id),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              product.image,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '\$${product.price.toString()}',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[700]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
