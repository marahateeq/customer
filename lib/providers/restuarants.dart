import 'package:customertest/providers/restuarant.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Restaurants with ChangeNotifier {
  List<Restaurant> _items = [];
  String authToken = '';
  String userId = '';

  getData(String authTok, String uId, List<Restaurant> restaurants) {
    authToken = authTok;
    userId = uId;
    _items = restaurants;
    notifyListeners();
  }

  List<Restaurant> get items {
    return [..._items];
  }

  Restaurant findById(String id) {
    return _items.firstWhere((rest) => rest.id == id);
  }

  Restaurant findByName(String name) {
    return _items.firstWhere((rest) => rest.name == name);
  }

  Future<void> fetchAndSetRestaurants([bool filterByUser = false]) async {
    var url =
        'https://test1-cf86f-default-rtdb.firebaseio.com/restaurants.json?auth=$authToken';

    try {
      final res = await http.get(Uri.parse(url));
      final extractData = json.decode(res.body) as Map<String, dynamic>;
      if (extractData == null) {
        return;
      }

      final List<Restaurant> loadedRestaurants = [];
      extractData.forEach((restId, restData) {
        loadedRestaurants.add(Restaurant(
          id: restData['creatorId'],
          name: restData['name'],
          address: restData['address'],
          imageUrl: restData['imageUrl'],
        ));
        _items = loadedRestaurants;
        notifyListeners();
      });
    } catch (e) {
      rethrow;
    }
  }

  /*Future<void> fetchRestaurant(String id) async{

    final filteredString = 'orderBy="creatorId"&equalTo="$id"';

    var url = 'https://test1-cf86f-default-rtdb.firebaseio.com/restaurants.json?auth=$authToken&filteredString';

    try{
      final res = await http.get(Uri.parse(url));
      final extractData = json.decode(res.body);
      if (extractData == null){
        return;
      }
        _rest = extractData as Restaurant;
      notifyListeners();
    }catch(e){
      throw e ;
    }
  }*/

}
