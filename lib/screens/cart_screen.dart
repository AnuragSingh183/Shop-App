import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/cartitem.dart';
import '../providers/carts.dart';
import '../widgets/cartitem.dart';

class CartScreen extends StatefulWidget {
  static const routename = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final wish =
        Provider.of<Cart>(context); //<> contains the class with change notifier
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Your Cart"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Chip(
                            label: Text('\$${wish.totalAmount}'),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          // ignore: deprecated_member_use
                          FlatButton(
                              onPressed: wish.totalAmount <= 0 || _isLoading
                                  ? null
                                  : () {
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      Provider.of<Orders>(context,
                                              listen: false)
                                          .addOrders(wish.items.values.toList(),
                                              wish.totalAmount);

                                      setState(() {
                                        _isLoading = false;
                                      });
                                      wish.clear();
                                    },
                              child: Text("ORDER NOW"))
                        ],
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: //listview cant be directly used in a cloumn so we use it with expanded to maximum space as it can.
                        ListView.builder(
                            itemCount: wish.count,
                            itemBuilder: (ctx, i) => Cartitem(
                                //cartitem widget shows how one product in the cart will look like.
                                wish.items.values
                                    .toList()[i]
                                    .id, //items is a map we can take just a null value. we r interested in its value.
                                wish.items.keys.toList()[i],
                                wish.items.values.toList()[i].price,
                                wish.items.values.toList()[i].quantity,
                                wish.items.values.toList()[i].title))),
              ],
            ),
    );
  }
}
