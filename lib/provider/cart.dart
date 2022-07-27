import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String title;
  final int quanitity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quanitity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quanitity;
    });
    return total;
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  void addCartItems(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      // change quanitity becouse we have the ID
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quanitity: existingCartItem.quanitity + 1,
                price: existingCartItem.price,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quanitity: 1,
              price: price));
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quanitity > 1) {
      _items.update(
          productId,
          (data) => CartItem(
              id: data.id,
              title: data.title,
              quanitity: data.quanitity - 1,
              price: data.price));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearItem() {
    _items = {};
    notifyListeners();
  }
}
