import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_detail.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  //final String title;
  //final String id;
  //final String imageUrl;
  //ProductItem(this.imageUrl, this.title, this.id);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
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
                product.toggleisFav();
              },
              icon:
                  Icon(product.isFav ? Icons.favorite : Icons.favorite_border)),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing:
              IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        ),
      ),
    );
  }
}
