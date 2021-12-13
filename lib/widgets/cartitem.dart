import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/carts.dart';

class Cartitem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final String title;
  final int quantity;
  Cartitem(this.id, this.productId, this.price, this.quantity, this.title);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeitem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text("\$$price")),
            ),
            title: Text(title),
            subtitle: Text("total:\$${price * quantity}"),
            trailing: Text("$quantity X"),
          ),
        ),
      ),
    );
  }
}



//screen shows how the screen looks like and _item.dart shows how an item looks like in the screen.