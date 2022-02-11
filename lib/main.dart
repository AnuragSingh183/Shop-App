import 'package:flutter/material.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail.dart';
import './screens/productoverview.dart';
import 'package:shop_app/screens/user_product.dart';
import './providers/products_provider.dart';
import 'package:provider/provider.dart';
import './providers/carts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            //first arg. is the class that it depends on and second is the class that it provides
            //product class will rebuild whenever auth changes
            create: (ctx) =>
                Products(Provider.of<Auth>(ctx, listen: false).token, []),

            update: (ctx, auth, previousProducts) => Products(auth.token,
                previousProducts == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProvider(create: (context) => Cart()),
          ChangeNotifierProvider(
            create: (context) => Orders(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Shop App',
            debugShowCheckedModeBanner: false,
            home: auth.isAuth ? Productoverview() : AuthScreen(),
            routes: {
              ProductDetail.routename: (ctx) => ProductDetail(),
              CartScreen.routename: (ctx) => CartScreen(),
              OrderScreen.routename: (ctx) => OrderScreen(),
              UserProducts.routeName: (ctx) => UserProducts(),
              EditProduct.routeName: (ctx) => EditProduct()
            },
          ),
        ));
  }
}
