import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail.dart';
import 'package:shop_app/screens/productoverview.dart';
import './providers/products_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'Shop App',
        debugShowCheckedModeBanner: false,
        home: Productoverview(),
        routes: {ProductDetail.routename: (ctx) => ProductDetail()},
      ),
    );
  }
}
