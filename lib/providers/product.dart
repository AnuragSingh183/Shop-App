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

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': this.imageUrl,
      'description': this.description,
      'price': this.price,
      'title': this.title,
      'isFav': this.isFav,
    };
  }

  Future<void> toggleisFav() async {
    final oldStatus = this.isFav;

    this.isFav = !this.isFav;
    isFav = this.isFav;
    final url =
        "https://shop-app-a70e5-default-rtdb.firebaseio.com/products.json";

    try {
      final response = await http.patch(Uri.parse(url),
          body: json.encode({this.id: this.toMap()}));
      if (response.statusCode >= 400) {
        isFav = oldStatus;
        notifyListeners();
      }
      notifyListeners();
    } catch (error) {
      isFav = oldStatus;
      notifyListeners();
    }

    this.isFav = isFav;

    //equivalent to set state in providers.
  }
}
