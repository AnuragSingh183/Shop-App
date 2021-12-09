import 'package:flutter/material.dart';

class cartItem {
  String id;
  String title;
  double price;
  int quantity;

  cartItem({this.id, this.title, this.price, this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, cartItem> _items =
      {}; //will not work if it is uninitialized so have to initilize as an empty map.

  Map<String, cartItem> get items {
    return {...items};
  }

  int get count {
    return _items.length;
  }

  void additem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => cartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => cartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }
}
