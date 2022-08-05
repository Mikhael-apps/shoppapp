import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
   bool isFavorite;

  Product(
      {
      required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
       this.isFavorite = false
      }
      );

      void _setFavs(bool newValue) {
        isFavorite = newValue;
        notifyListeners();
      }

    Future<void> toggleFavoriteStatus() async {
      final oldFavoriteStatus= isFavorite;

      isFavorite = !isFavorite;
      notifyListeners();
    var url = Uri.parse('http://shopapp-67412-default-rtdb.firebaseio.com/products/$id.json');
    try {
      final response = await http.patch(
      url, 
      body: json.encode({
      'isFavorite': isFavorite,
    }));
    if(response.statusCode >= 400) {
      _setFavs(oldFavoriteStatus);
    }
    } catch (error) {
      
      _setFavs(oldFavoriteStatus);
    }
    
    }
}
