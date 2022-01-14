import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  //mixins same as inheritence but the connection is weAK. dart doesnot support multiple inheritence but with mixins we can add as many properties as we can.
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  List<Product> get FavouriteItems {
    return items.where((proditem) => proditem.isFav).toList();
  }

  List<Product> get items {
    //to fetch private properties like _items use getters
    return [..._items]; //copy of items
  }

  Future<void> fetchProduct() async {
    const url =
        "https://shop-app-a70e5-default-rtdb.firebaseio.com/products.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String,
          dynamic>; //get url returning a nested map with id as keys and data as values
      final List<Product> loadedData = [];
      extractedData.forEach((prodId, ProdData) {
        //we need to convert these prod data into objects for items
        loadedData.add(Product(
          //{id:{title:value}}
          id: prodId,
          description: ProdData["description"],
          title: ProdData["title"],
          imageUrl: ProdData["imageUrl"],
          price: ProdData["price"],
          isFav: ProdData["isFav"],
        ));
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
    const url =
        "https://shop-app-a70e5-default-rtdb.firebaseio.com/products.json";
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
        "https://shop-app-a70e5-default-rtdb.firebaseio.com/products.json";
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
