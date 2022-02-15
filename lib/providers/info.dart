import 'package:flutter/material.dart';

class Info with ChangeNotifier {
  String id;
  String fname;
  String lname;
  String number;
  String address;
  String email;

  Info(
      {this.id,
      @required this.fname,
      @required this.lname,
      this.address,
      @required this.number,
      this.email});
}
