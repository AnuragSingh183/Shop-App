import 'package:flutter/material.dart';
import 'package:shop_app/providers/carts.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<cartItem> products;
  final DateTime date;

  OrderItem({this.id, this.amount, this.products, this.date});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrders(List<cartItem> cartproducts, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            date: DateTime.now(),
            products: cartproducts));

    notifyListeners();
  }
}
