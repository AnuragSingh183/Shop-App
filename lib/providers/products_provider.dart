import 'dart:convert';

import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  //mixins same as inheritence but the connection is weAK. dart doesnot support multiple inheritence but with mixins we can add as many properties as we can.
  List<Product> _items = [];

  final String authToken;
  Products(this.authToken, this._items);

  List<Product> get FavouriteItems {
    return items.where((proditem) => proditem.isFav).toList();
  }

  List<Product> get items {
    //to fetch private properties like _items use getters
    return [..._items]; //copy of items
  }

  Future<void> fetchProduct() async {
    final url =
        "https://shop-app-a70e5-default-rtdb.firebaseio.com/products.json?auth=$authToken";
    try {
      final response = await http.get(Uri.parse(url));

      final extractedData = json.decode(response.body) as Map<String,
          dynamic>; //get url returning a nested map with id as keys and data as values
      List<Product> loadedData = [];
      extractedData.forEach((prodId, ProdData) {
        //we need to convert these prod data into objects for items
        Product product = Product(
            //{id:{title:value}}
            id: prodId,
            description: ProdData["description"],
            title: ProdData["title"],
            imageUrl: ProdData["imageUrl"],
            price: ProdData["price"],
            isFav: ProdData["isFav"],
            authToken: ProdData["authToken"]);
        loadedData.add(product);
      });
      _items = loadedData;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addProducts(Product product) async {
    //async auto returns a future
    final url =
        "https://shop-app-a70e5-default-rtdb.firebaseio.com/products.json?auth=$authToken";
    try {
      //we use try in the code block which is likely to fail.
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "title": product.title,
            "description": product.description,
            "id": product.id,
            "imageUrl": product.imageUrl,
            "price": product.price,
            "isFav": product.isFav,
          }));

      final newProduct = Product(
          title: product.title,
          description: product.description,
          imageUrl: product.imageUrl,
          id: json.decode(response.body)[
              "name"], //backend id will be the default id everywhere
          price: product.price);
      _items.add(newProduct);
      //_items.insert(0, newProduct);to insert at the start
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Product findbyId(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> deleteProduct(String id) {
    final url =
        "https://shop-app-a70e5-default-rtdb.firebaseio.com/products.json?auth=$authToken";
    final existingProductIndex = _items.indexWhere((prod) =>
        prod.id == id); //will gib the index for the product for deletion
    var existingProduct =
        _items[existingProductIndex]; //pointer for the product

    http.delete(Uri.parse(url)).then((_) {
      existingProduct = null;
    }).catchError((_) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
    });
    _items.removeAt(existingProductIndex);
    notifyListeners();
  }
}
