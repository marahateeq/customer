import 'package:flutter/material.dart';

class ReservationInfo extends StatefulWidget {
  const ReservationInfo({Key key}) : super(key: key);
  static const routeName = '/ReservationInfo';
  @override
  _ReservationInfoState createState() => _ReservationInfoState();
}

class _ReservationInfoState extends State<ReservationInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve Information'),
      ),
    );
  }
}
