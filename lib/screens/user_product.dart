import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/drawer.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';

class UserProducts extends StatelessWidget {
  static const routeName = "/userProduct";
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Products"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: productData.items.length,
        itemBuilder: (_, i) => UserProductItem(
            productData.items[i].title, productData.items[i].imageUrl),
      ),
    );
  }
}
