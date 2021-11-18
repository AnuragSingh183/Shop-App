import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';

import './productitem.dart';
import "package:provider/provider.dart";

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Products>(
        context); //does the bts process and checks for listners in the parent widgets and for same instances i.e Products
    final loadedproducts = showFavs
        ? productsdata.FavouriteItems
        : productsdata.items; //if showsfavs true then favitems
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: loadedproducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider(
        create: (c) => loadedproducts[
            i], //will return single product and will do multiple times bcz of item builder.
        child: ProductItem(//loadedproducts[i].imageUrl,
            //loadedproducts[i].title, loadedproducts[i].id
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
