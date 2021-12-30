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
    return {..._items};
  }

  int get count {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
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

  void removesingleitem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => cartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity - 1,
              price: existingCartItem.price));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeitem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners(); //will clear the items in the cartscreen
  }
}
