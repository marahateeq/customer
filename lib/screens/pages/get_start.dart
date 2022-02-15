import 'package:customertest/screens/pages/tips.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key key}) : super(key: key);
  static const routeName = '/getstarted';

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height / 3;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              //width: double.infinity,
              //height: double.infinity,
              //color: Colors.deepOrangeAccent,
              child: Column(
            children: <Widget>[
              Container(
                height: myheight * 1.5,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage("images/tip5.png"),
                        fit: BoxFit.fill)),
              ),
              SizedBox(
                height: myheight * 0.45,
              ),
              Container(
                height: myheight * 0.86,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.orange.shade200,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3))
                    ],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: ListView(
                  children: <Widget>[
                    Column(
                      textDirection: TextDirection.ltr,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Happy Meals",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                            'Discover the best food from several restaurants.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300)),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const Tips();
                              }));
                            },
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 30.0,
                                    right: 30.0,
                                    top: 5.0,
                                    bottom: 5.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: const Text(
                                  "Get started",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
