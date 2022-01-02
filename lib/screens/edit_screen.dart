import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  static const routeName = "/EditProduct";

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditProduct> {
  final _prizefocus = FocusNode();
  final _descriptionfocus = FocusNode();
  final _imageUrl = TextEditingController();

  void dispose() {
    _prizefocus.dispose();
    _descriptionfocus.dispose();
    _imageUrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Edit Product"),
      ),
      body: Form(
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "title"),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_prizefocus);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Price"),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _prizefocus,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionfocus);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Description"),
              maxLines: 3,
              keyboardType: TextInputType
                  .multiline, //multiline will give enter no need for next.
              focusNode: _descriptionfocus,
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(left: 8, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: _imageUrl.text.isEmpty
                      ? Text("Enter the url")
                      : FittedBox(
                          child: Image.network(_imageUrl.text),
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "imageUrl"),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrl, //for the preview in the textfield.
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
