// main.dart
import 'package:flutter/material.dart';
import 'package:product_app/providers/product_provider.dart';
import 'package:product_app/screens/product_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fake Store',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductListScreen(),
      ),
    );
  }
}
