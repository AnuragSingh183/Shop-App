import 'package:flutter/material.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  final String id;
  final String price;

  ProductDetail({this.id, this.price});
  static const routename = "/ProductDetail";

  @override
  Widget build(BuildContext context) {
    final ProductId = ModalRoute.of(context).settings.arguments as String;
    final loaded =
        Provider.of<Products>(context, listen: false).findbyId(ProductId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loaded.title),
      ),
    );
  }
}
