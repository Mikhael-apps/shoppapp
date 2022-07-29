import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppapp/provider/product.dart';
import 'package:shoppapp/provider/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routName = '/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var isInit = true;

  @override
  void initState() {
    // TODO: implement initState
    _imageFocusNode.removeListener(_updateImage);
    super.initState();
  }

  void _updateImage() {
    if (!_imageFocusNode.hasFocus) {
      
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if(!isValid) {
      return;
    }
    _form.currentState!.save();
    if(_editProduct.id != null) {
      Provider.of<Products>(context, listen: false).addProduct(_editProduct);
    } else {
      Provider.of<Products>(context, listen: false).updateProduct(_editProduct.id, _editProduct);
      
    }
    
    Navigator.pop(context);
    // print(_editProduct.title);
    // print(_editProduct.price);
    // print(_editProduct..imageUrl);
    // print(_editProduct.description);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageController.dispose();
    _imageFocusNode.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      if(productId != null) {
        _editProduct = Provider.of<Products>(context, listen: false).findById(productId as String);
      _initValues = {
        'title': _editProduct.title,
        'description': _editProduct.description,
        'price': _editProduct.price.toString(),
        // 'imageUrl': _editProduct.imageUrl,
        'imageUrl': '',
      };
      _imageController.text = _editProduct.imageUrl;
      }
      

    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editProduct = Product(
                        id: _editProduct.id,
                        isFavorite: _editProduct.isFavorite,
                        title: value as String,
                        description: _editProduct.description,
                        price: _editProduct.price,
                        imageUrl: _editProduct.imageUrl
                        );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  focusNode: _priceFocusNode,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'Please enter a price';
                    }
                    if(double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    if(double.parse(value) < 0) {
                      return 'Please eneter a posititive number';
                    }
                  },
                  onSaved: (value) {
                    _editProduct = Product(
                        id: _editProduct.id,
                        isFavorite: _editProduct.isFavorite,
                        title: _editProduct.title,
                        description: _editProduct.description,
                        price: double.parse(value as String),
                        imageUrl: _editProduct.imageUrl
                        );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                   onSaved: (value) {
                    _editProduct = Product(
                        id: _editProduct.id,
                        isFavorite: _editProduct.isFavorite,
                        title: _editProduct.title,
                        description: value as String,
                        price: _editProduct.price,
                        imageUrl: _editProduct.imageUrl,
                        );
                  },
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please enter a description';
                    }
                    if(value.length < 10) {
                      return 'Should be at least 10 characters long';
                    }
                    return null;
                  },
                  // focusNode: _priceFocusNode,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: _imageController.text.isEmpty
                            ? Text('Enter a url')
                            : FittedBox(
                                child: Image.network(
                                  _imageController.text,
                                  fit: BoxFit.cover,
                                ),
                              )),
                    Expanded(
                      child: TextFormField(
                        // initialValue: _initValues['imageUrl'],
                        decoration:
                            InputDecoration(labelText: 'Enter url image'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageController,
                        focusNode: _imageFocusNode,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Please enter a url';
                          }
                          // if(value.startsWith('http:') || value.startsWith('https:')){
                          //   return 'Please enter a valid url';
                          // }
                          // if(value.endsWith('.png') || value.endsWith('.jpg') || value.endsWith('.jpeg')){
                          //   return 'Please enter a valid image url';
                          // }
                          return null;
                        },
                      onSaved: (value) {
                    _editProduct = Product(
                        id: _editProduct.id,
                        isFavorite: _editProduct.isFavorite,
                        title: _editProduct.title,
                        description: _editProduct.description,
                        price: _editProduct.price,
                        imageUrl: value as String,
                        );
                  },
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
