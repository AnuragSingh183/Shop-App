import 'package:flutter/material.dart';
import 'package:shop_app/providers/carts.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_detail.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import "../providers/carts.dart";

class ProductItem extends StatelessWidget {
  //final String title;
  //final String id;
//final String imageUrl;
//  ProductItem(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetail.routename, arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
              onPressed: () {
                product.toggleisFav(authData.token, authData.userId);
              },
              icon:
                  Icon(product.isFav ? Icons.favorite : Icons.favorite_border)),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              onPressed: () {
                cart.additem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context)
                    .hideCurrentSnackBar(); //to hide the current bar
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //searches for the nearest scaffold widget

                  content: Text("Added to Cart"),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        cart.removesingleitem(product.id);
                      }),
                ));
              },
              icon: Icon(Icons.shopping_cart)),
        ),
      ),
    );
  }
}
