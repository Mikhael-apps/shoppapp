import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shoppapp/provider/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
   List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  // if we jave privat method so we must final use

  // var showFavoriteOnly = false;

  List<Product> get items {
    // if(showFavoriteOnly) {
    //   return items.where((data) => data.isFavorite).toList();
    // }
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((data) => data.id == id);
  }

  // void showFavorotesOnly() {
  //   showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   showFavoriteOnly = false;
  //   notifyListeners();
  // }

  List<Product> get showFavorites {
    return items.where((data) => data.isFavorite).toList();
  }

  Future<void> fetchAndSetProducts() async {
    var url = Uri.parse('https://shopapp-67412-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      // print(json.encode(response.body));
      final exttractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      exttractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite'],
            imageUrl: prodData['imageUrl'],
          )
        );
       
      });
       _items = loadedProducts;
       notifyListeners();
    } catch(error) {
      throw error;
    }
    
  }

  Future<void> addProduct(Product product) async {
    // _items.add(product);
    // const url = 'https://shopapp-67412-default-rtdb.firebaseio.com/products.json';
    var url = Uri.parse('http://shopapp-67412-default-rtdb.firebaseio.com/products.json');
    try {
    final response = await http.post(url, body: json.encode({
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'imageUrl': product.imageUrl,
      'isFavorite': product.isFavorite,

    })
    );
    final newProducts = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl
        );
        _items.add(newProducts);
        notifyListeners();
    } catch(error) {
      print(error);
      throw error;
    }
      
        
        // _items.insert(0, newProducts); at the start of the list
    
  
      // print(error);
   
   
    
  }

  

  Future<void> updateProduct(String id, Product newProduct) async {
   final productsData = _items.indexWhere((data) => data.id == id); // what is it indexWhere?
   
   if(productsData >= 0){
    var url = Uri.parse('http://shopapp-67412-default-rtdb.firebaseio.com/products/$id.json');
    await http.patch(url, body: json.encode({
      'title': newProduct.title,
      'description': newProduct.description,
      'price': newProduct.price,
      'imageUrl': newProduct.imageUrl,
    }));
    _items[productsData] = newProduct;
    notifyListeners();
   } else {
    print('...updated');
   }
  }

  void deleteProduct(String id) {
    var url = Uri.parse('http://shopapp-67412-default-rtdb.firebaseio.com/products/$id.json');
    var existingProductsIndex = _items.indexWhere((data) => data.id == id);
    Product? existingProduct = _items[existingProductsIndex];
    _items.removeAt(existingProductsIndex);
    notifyListeners();
    http.delete(url).then((response) {
      // print(response.statusCode);
      if(response.statusCode >= 400) {
        
      }
      existingProduct = null;
    }).catchError((_) {
      _items.insert(existingProductsIndex, existingProduct as Product);
      notifyListeners();
    });
    _items.removeWhere((data) => data.id == id);
    notifyListeners();
  }
}
