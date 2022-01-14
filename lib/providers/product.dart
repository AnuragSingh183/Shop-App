import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String imageUrl;
  final String description;
  final double price;
  bool isFav;
  final String title;

  Product(
      {this.imageUrl,
      this.description,
      this.id,
      this.isFav = false,
      this.price,
      this.title});

  Future<void> toggleisFav() async {
    final oldStatus = isFav;

    isFav = !isFav;
    final url =
        "https://shop-app-a70e5-default-rtdb.firebaseio.com/products.json";

    try {
      await http.patch(Uri.parse(url),
          body: json.encode({
            "isFav": isFav,
          }));
      notifyListeners();
    } catch (error) {
      isFav = oldStatus;
      notifyListeners();
    }

    //equivalent to set state in providers.
  }
}
