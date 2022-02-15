import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavoriteValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;

    isFavorite = !isFavorite;
    notifyListeners();
    // reflect the change in  the backend
    final url =
        'https://test1-cf86f-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      // modify only one value
      final res = await http.put(
        Uri.parse(url), // no need to use map
        body: json.encode(isFavorite),
      ); // isFavorite : is the new value
      if (res.statusCode >= 400) {
        // happens an error
        _setFavoriteValue(oldStatus);
      }
    } catch (e) {
      _setFavoriteValue(oldStatus);
    }
  }
}
