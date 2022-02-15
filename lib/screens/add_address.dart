import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key key}) : super(key: key);
  static const routeName = '/AddAddress';

  @override
  _AddAddressState createState() => _AddAddressState();
}

// AIzaSyDdPFbJUoe5JFo7gkiJYBOg1vsXOyQSMFU
class _AddAddressState extends State<AddAddress> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
