import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_product.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("SUP"),
            automaticallyImplyLeading: false, //will never add a back button
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: () {
              Navigator.of(context).pushNamed("/");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("orders"),
            onTap: () {
              Navigator.of(context).pushNamed(OrderScreen.routename);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage Products"),
            onTap: () {
              Navigator.of(context).pushNamed(UserProducts.routeName);
            },
          )
        ],
      ),
    );
  }
}
