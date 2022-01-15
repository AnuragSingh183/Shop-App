// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class EditProduct extends StatefulWidget {
  static const routeName = "/EditProduct";

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditProduct> {
  final _prizefocus = FocusNode();
  final _descriptionfocus = FocusNode();
  final _imageUrlfocus = FocusNode();
  final _imageUrl = TextEditingController();
  final _form = GlobalKey<
      FormState>(); //global key will allow us to interact with the state behind the form widget

  var _editedProduct =
      Product(title: " ", id: null, price: 0, description: " ", imageUrl: " ");

  void dispose() {
    _prizefocus.dispose();
    _descriptionfocus.dispose();
    _imageUrl.dispose();
    super.dispose();
  }

  var _isLoading = false;

  Future<void> _saveForm() async {
    //add products returning a future
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return null;
    }
    _form.currentState
        .save(); //save method provided by flutter to save the form
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Products>(context, listen: false)
          .addProducts(_editedProduct);
    } catch (error) {
      await showDialog(
          //show dialog also returns future
          context: context,
          builder: (context) => AlertDialog(
                title: Text("An Error Occured"),
                content: Text("Something Went Wrong"),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"))
                ],
              ));
    }
    //then block will only be executed once the user presses the ok button in the error message.

     finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Edit Product"),
        actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: "title"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(
                            _prizefocus); //focus is for directly shifting to next form after pressing enter in the keyboard
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: value,
                            id: _editedProduct.id,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter the title";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          labelText: "Price",
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _prizefocus,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionfocus);
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              title: _editedProduct.title,
                              id: _editedProduct.id,
                              price: double.parse(value),
                              description: _editedProduct.description,
                              imageUrl: _editedProduct.imageUrl);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter the Price";
                          }
                          if (double.tryParse(value) == null) {
                            return "Please enter a Valid Price ";
                          }
                          if (double.parse(value) <= 0) {
                            return "Please return a Valid Price";
                          }
                          return null;
                        }),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Description"),
                      maxLines: 3,
                      keyboardType: TextInputType
                          .multiline, //multiline will give enter no need for next.
                      focusNode: _descriptionfocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_imageUrlfocus);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: _editedProduct.title,
                            id: _editedProduct.id,
                            price: _editedProduct.price,
                            description: value,
                            imageUrl: _editedProduct.imageUrl);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter the Description";
                        }

                        if (value.length < 10) {
                          return "Please enter a Description longer than 10 Characters";
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                            controller:
                                _imageUrl, //for the preview in the textfield.
                            focusNode: _imageUrlfocus,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                  title: _editedProduct.title,
                                  id: _editedProduct.id,
                                  price: _editedProduct.price,
                                  description: _editedProduct.description,
                                  imageUrl: value);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please Enter the ImageUrl";
                              }
                              if (!value.startsWith("http") &&
                                  !value.startsWith("https")) {
                                return "Please Enter a valid Url";
                              }
                              if (!value.endsWith(".png") &&
                                  !value.endsWith(".jpeg") &&
                                  !value.endsWith("jpg")) {
                                return "Please enter a valid url";
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
