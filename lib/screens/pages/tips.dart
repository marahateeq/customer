import 'package:customertest/screens/auth_sc.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class Tips extends StatefulWidget {
  const Tips({Key key}) : super(key: key);

  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  var myarr = [
    {
      "title": "Finds food you love",
      "info": "Discover the best food from several restaurants.",
      "image": "images/tip2.png"
    },
    {
      "title": "Fast Delivery ",
      "info": "Fast delivery to your home, office and wherever you are",
      "image": "images/tip6.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height / 6;
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: myheight * 4,
              child: PageIndicatorContainer(
                shape: IndicatorShape.circle(),
                length: myarr.length,
                align: IndicatorAlign.bottom,
                indicatorColor: Colors.grey,
                indicatorSelectorColor: Colors.deepOrange,
                child: PageView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: myarr.length,
                    itemBuilder: (BuildContext context, i) {
                      return SingleTips(
                          title: myarr[i]["title"],
                          info: myarr[i]["info"],
                          image: myarr[i]["image"]);
                    }),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: <Widget>[
                    Column(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(AuthSC.routeName);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.deepOrange,
                            ),
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                  fontSize: 30.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}

class SingleTips extends StatelessWidget {
  final String title;
  final String info;
  final String image;

  const SingleTips({this.title, this.info, this.image});
  @override
  Widget build(BuildContext context) {
    double myheight = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
          height: myheight * 0.5,
          alignment: Alignment.center,
          child: Image.asset(
            image,
            fit: BoxFit.fill,
            height: myheight * 0.5,
          ),
        )),
        const SizedBox(
          height: 20,
        ),
        Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            )),
        Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: Text(
              info,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
