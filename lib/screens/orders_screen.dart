import 'package:flutter/material.dart';
import 'package:shop_app/widgets/drawer.dart';
import '../providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routename = "/orders";

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Your Orders"),
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (context, i) => OrderItem(orderData.orders[i]),
        ));
  }
}
