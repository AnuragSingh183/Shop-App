import 'package:flutter/material.dart';

 class ProductItem extends StatelessWidget {
   final String title;
   final String id;
   final String imageUrl;
   ProductItem(this.imageUrl,this.title,this.id);
  

  @override
  Widget build(BuildContext context) {
    return GridTile(
      
      child: Image.network(imageUrl,fit: BoxFit.cover,),
      footer:
      
       GridTileBar(
         backgroundColor:Colors.black54,
         leading: Icon(Icons.favorite),
         trailing: Icon(Icons.shopping_cart),
         title: Text(title,textAlign: TextAlign.center,),)
    );
  }
}