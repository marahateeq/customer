import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashSC extends StatelessWidget {
  const SplashSC({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      image: Image.asset(
        'images/icon.png',
        fit: BoxFit.fill,
      ),
      seconds: 5,
      navigateAfterSeconds: const AfterSplash(),
      // ignore: unnecessary_new
      title: const Text(
        'Welcome to our app',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      //image: new Image.network(
      //  'https://flutter.io/images/catalog-widget-placeholder.png'),
      backgroundColor: Colors.orangeAccent,
      loaderColor: Colors.red,
    );
  }
}

class AfterSplash extends StatelessWidget {
  const AfterSplash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome In SplashScreen Package"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Image.asset(
        'images/icon.png',
        fit: BoxFit.fill,
      )),
    );
  }
}
