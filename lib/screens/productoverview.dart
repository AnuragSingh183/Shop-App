import "package:flutter/material.dart";

import 'package:shop_app/widgets/products_grid.dart';

enum filteroptions { favourites, all }

class Productoverview extends StatefulWidget {
  @override
  State<Productoverview> createState() => _ProductoverviewState();
}

class _ProductoverviewState extends State<Productoverview> {
  var _showonlyfavs = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
            )
          ],
        ),
        body: ProductsGrid(_showonlyfavs));
  }
}
