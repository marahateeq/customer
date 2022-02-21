import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final TimeOfDay timeOfDay;
  bool Delivery = false;

  OrderItem(
      {this.id, this.amount, this.products, this.dateTime, this.timeOfDay});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  String authToken = '';
  String userId = '';

  getData(
    String authTok,
    String uId,
    List<OrderItem> orders,
  ) {
    authToken = authTok;
    userId = uId;
    _orders = orders;

    notifyListeners();
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    print(authToken);
    print(userId);
    final url =
        'https://test1-cf86f-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    // final : will not change
    try {
      final res = await http.get(Uri.parse(url));
      final extractData = json.decode(res.body) as Map<String, dynamic>;
      if (extractData == null) {
        return;
      }
      print(extractData);

      final List<OrderItem> loadedOrders = [];
      extractData.forEach((orderId, orderData) {
        // print(orderData);
        loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['datetime']),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price']))
              .toList(),
        ));
        _orders = loadedOrders.reversed.toList();
        // print(_orders); //reversed:  اخر طلب يصبح بالبداية

        notifyListeners();
      });
    } catch (e) {
      // print(e);

      rethrow;
    }
  }

  //////////////////////

  Future<void> addOrders(
    List<CartItem> cartProduct,
    double total,
    bool status,
    TimeOfDay time,
    DateTime date,
    String no,
  ) async {
    final url =
        'https://test1-cf86f-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken'; //

    try {
      final timestamp = DateTime.now();
      final res = await http.post(Uri.parse(url),
          body: json.encode(// send data to firebase
              {
            'id': userId,
            'amount': total,
            'timeofday': time.toString(),
            'datetime': date.toString(),
            'delivery': status,
            'numberofpeople': status == true ? '0' : no,
            'products': cartProduct
                .map((cartprod) => {
                      'title': cartprod.title,
                      'quantity': cartprod.quantity,
                      'price': cartprod.price,
                      'resId': cartprod.restId,
                    })
                .toList(),
          }));

      _orders.insert(
          0,
          OrderItem(
            id: userId,
            amount: total,
            products: cartProduct,
            dateTime: date,
            timeOfDay: time,
          ));

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
