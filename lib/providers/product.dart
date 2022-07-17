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
  final String authToken;

  Product(
      {this.imageUrl,
      this.description,
      this.id,
      this.isFav = false,
      this.price,
      this.title,
      this.authToken});

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': this.imageUrl,
      'description': this.description,
      'price': this.price,
      'title': this.title,
      'isFav': this.isFav,
    };
  }

  Future<void> toggleisFav(String token, String userId) async {
    final oldStatus = isFav;
    isFav = !isFav;
    notifyListeners();

    isFav = this.isFav;
    final url =
        "https://shop-app-a70e5-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$authToken";

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
  }
}
