import 'package:customertest/providers/product.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  String authToken = '';
  String userId = '';

  getData(String authTok, String uId, List<Product> products) {
    // return previous data
    authToken = authTok;
    userId = uId;
    _items = products;
    notifyListeners();
  }

  List<Product> get items {
    return [..._items]; // ... spread operator
  }

  List<Product> get favoriteitems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    // deal with server
    //final filteredString = filterByUser? 'orderBy="creatorId"&equalTo="$userId"'  :  '';
    var url =
        'https://test1-cf86f-default-rtdb.firebaseio.com/products.json?&auth=$authToken'; //

    try {
      final res = await http.get(Uri.parse(url));
      final extractData = json.decode(res.body)
          as Map<String, dynamic>; // key is String , value is dynamic
      if (extractData.toString() == null) {
        return;
      }
      url =
          'https://test1-cf86f-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken'; //
      //اعطيني المنتجات المفضلة بالنسبة لهاد الشخص
      final favRes = await http.get(Uri.parse(url));
      final favData = json.decode(favRes.body);

      final List<Product> loadedProducts = [];
      extractData.forEach((prodId, prodData) {
        //prodData is map
        loadedProducts.add(Product(
          //restaurantId: userId!,
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: favData == null ? false : favData[prodId] ?? false,
        ));
        _items = loadedProducts;
        //print(_items.toString());
        notifyListeners();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchAndSetResProducts(String resCreatorId) async {
    //String resCreatorId

    final filteredString = 'orderBy="creatorId"&equalTo="$resCreatorId"';
    var url =
        'https://test1-cf86f-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filteredString';

    try {
      final res =
          await http.get(Uri.parse(url)); // بجيب بيانات من السيرفر اللي عنا
      final extractData = json.decode(res.body) as Map<String, dynamic>;
      if (extractData.toString() == null) {
        return;
      }

      url =
          'https://test1-cf86f-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken'; //
      //اعطيني المنتجات المفضلة بالنسبة لهاد الشخص
      final favRes = await http.get(Uri.parse(url));
      final favData = json.decode(favRes.body);

      final List<Product> loadedProducts = [];
      extractData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId, // prodData['creatorId'],
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite: favData == null ? false : favData[prodId] ?? false,
        ));
        _items = loadedProducts;
        print(loadedProducts);
      });
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
