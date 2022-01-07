import 'package:flutter/material.dart';
import 'product.dart';

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

  void addProducts(Product product) {
    //_items.add();
    final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        id: DateTime.now().toString(),
        price: product.price);
    _items.add(newProduct);
    //_items.insert(0, newProduct);to inset at the start
    notifyListeners();
  }

  Product findbyId(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
