import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_screen.dart';
import 'package:shop_app/widgets/drawer.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';

class UserProducts extends StatelessWidget {
  static const routeName = "/userProduct";

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Manage Products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProduct.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, i) => UserProductItem(productData.items[i].id,
              productData.items[i].title, productData.items[i].imageUrl),
        ),
      ),
    );
  }
}
