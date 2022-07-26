import 'package:flutter/cupertino.dart';
import 'package:shoppapp/provider/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrders(List<CartItem> products, double total) async {
    var url = Uri.parse('http://shopapp-67412-default-rtdb.firebaseio.com/orders.json');
    final response = await http.post(url, body: json.encode({
      'amount': total,
      'dateTime': DateTime.now().toIso8601String(),
      'products': products.map((data) => {
        'id': data.id,
        'title': data.title,
        'quantity': data.quanitity,
        'price': data.price,
      }).toList()
    }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: products,
            dateTime: DateTime.now()));
         notifyListeners();
  }
}
