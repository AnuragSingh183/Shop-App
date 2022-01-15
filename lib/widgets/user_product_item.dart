// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shop_app/screens/edit_screen.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  UserProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProduct.routeName);
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                      content: Text("Something Went Wrong",
                          textAlign: TextAlign.center)));
                }
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
