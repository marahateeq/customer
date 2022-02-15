import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'info.dart';

class UserInfo with ChangeNotifier {
  List<Info> _users = [];

  String authToken;
  String userId;

  getData(String authTok, String uId, List<Info> info) {
    authToken = authTok;
    userId = uId;
    _users = info;
    notifyListeners();
  }

  List<Info> get users {
    return [..._users];
  }

  Info findById(String id) {
    return _users.firstWhere((user) => user.id == id);
  }

  /*Future<void> fetchAndSetUserInfo () async{

    final filteredString = 'orderBy="creatorId"&equalTo="$userId"';
    var url = 'https://test1-cf86f-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filteredString';


    try{
      final res = await http.get(Uri.parse(url));
      final extractData = json.decode(res.body) as Map<String ,dynamic>; // key is String , value is dynamic
      // decode : receive from database

      if (extractData.toString() == null){
        return;
      }
      // url = 'https://test1-cf86f-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';//$userId.json : favorites for this user // authToken : using database only for user logged in
      //اعطيني المنتجات المفضلة بالنسبة لهاد الشخص
      //final favRes = await http.get(Uri.parse(url));
      //final favData = json.decode(favRes.body)  ; // is direct map // key is prodId give boolean value true or false


      final List<Info> loadedUserInfo = [];
      extractData?.forEach((prodId, prodData) {  // extractData is map ,  prodId is key , prodData is value
        loadedUserInfo.add(Info(
          id : prodId,
          title : prodData['title'],
          description : prodData['description'],
          price : prodData['price'],
          imageUrl : prodData['imageUrl'],
        ));
        _users = loadedUserInfo;

        notifyListeners();
      }
      );
    }catch(e){
      rethrow ;
    }
  }*/

////////////

  Future<void> addUI(Info uI) async {
    final url =
        'https://test1-cf86f-default-rtdb.firebaseio.com/users.json?auth=$authToken';

    try {
      final res = await http.post(
          // send data to database
          Uri.parse(url),
          body: json.encode(// encode :send
              {
            'id': userId,
            'fname': uI.fname,
            'lname': uI.lname,
            'number': uI.number,
            'address': uI.address,
            'email': uI.email,
          }));

      final newInfo = Info(
        id: userId,
        fname: uI.fname,
        lname: uI.lname,
        number: uI.number,
        address: uI.address,
        email: uI.email,
      );
      _users.add(newInfo);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

////////////

  Future<void> updateUI(String id, Info newUI) async {
    final userIndex = _users.indexWhere((user) => user.id == id); //userId;

    if (userIndex >= 0) {
      final url =
          'https://test1-cf86f-default-rtdb.firebaseio.com/users/$id.json?auth=$authToken';
      await http.patch(Uri.parse(url),
          body: json
              .encode(// patch : تحديث , modify on url  // encode : send updated info to firebase
                  {
            'fname': newUI.fname,
            'lname': newUI.lname,
            'number': newUI.number,
            'address': newUI.address,
            //'email' : newUI.email,
          }));
      // تعديل البيانات الموجودة عندي
      _users[userIndex] = newUI;
      notifyListeners(); // use it when change values
    } else {
      //print("in updateProduct ");
    }
  }
}
