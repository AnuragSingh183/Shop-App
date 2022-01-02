import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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

  void toggleisFav() {
    final oldStatus = isFav;

    isFav = !isFav;
    notifyListeners();
    //equivalent to set state in providers.
  }
}
