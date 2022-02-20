import 'package:flutter/foundation.dart';

class Restaurant with ChangeNotifier {
  
  final String id;
  final String name;
  final String address;
  final String imageUrl;

  Restaurant({
    @required this.id,
    @required this.name,
    @required this.address,
    @required this.imageUrl,
  });
}
