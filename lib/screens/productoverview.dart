import "package:flutter/material.dart";
import 'package:shop_app/providers/carts.dart';
import 'package:shop_app/screens/cart_screen.dart';
import '../widgets/drawer.dart';
import 'package:shop_app/widgets/products_grid.dart';
import '../widgets/badge.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

enum filteroptions { favourites, all }

class Productoverview extends StatefulWidget {
  static const routename = "/ProductOverview";
  @override
  State<Productoverview> createState() => _ProductoverviewState();
}

class _ProductoverviewState extends State<Productoverview> {
  var _showonlyfavs = false;
  var _isLoading = false;
  var _isInit = true;
  @override
  void initState() {
    // setState(() {
    //   _isLoading = true;
    // });
    //Provider.of<Products>(context).fetchProduct();// WONT WORK .OF(CONTEXT) DOESNOT WORK IN INIT STATE.
    //Future.delayed(Duration.zero).then((value) {
    //  Provider.of<Products>(context).fetchProduct().then((_) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   });
    // });
    super.initState();
  }

  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchProduct().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Black Market"),
          actions: [
            PopupMenuButton(
              onSelected: (filteroptions value) {
                setState(() {
                  if (value == filteroptions.favourites) {
                    _showonlyfavs = true;
                  } else {
                    _showonlyfavs = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text("Show Favourites"),
                  value: filteroptions.favourites,
                ),
                PopupMenuItem(
                  child: Text("Show All"),
                  value: filteroptions.all,
                )
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, _2) => Badge(
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(CartScreen.routename);
                      },
                      icon: Icon(Icons.shopping_cart)),
                  value: cart.count.toString()),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(_showonlyfavs));
  }
}
