import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/carts.dart';
import '../providers/product.dart';

class CartScreen extends StatelessWidget {
  static const routename = "/cart";
  @override
  Widget build(BuildContext context) {
    final wish =
        Provider.of<Cart>(context); //<> contains the class with change notifier
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: Column(
        children: [
          Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Chip(
                      label: Text('\$${wish.totalAmount}'),
                      backgroundColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
