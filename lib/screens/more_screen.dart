import 'package:customertest/const/colors.dart';
import 'package:customertest/utils/helper.dart';
import 'package:customertest/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';

import 'Homepage.dart';

class MoreScreen extends StatelessWidget {
  static const routeName = "/moreScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More '),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              height: Helper.getScreenHeight(context),
              width: Helper.getScreenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  MoreCard(
                    image: Image.asset(
                      "images/income.png",
                    ),
                    name: "Payment Details",
                    handler: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Homepage.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MoreCard(
                    image: Image.asset(
                      "images/shopping_bag.png",
                    ),
                    name: "My Orders",
                    handler: () {
                      Navigator.of(context).pushNamed(Homepage.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MoreCard(
                    image: Image.asset(
                      "images/noti.png",
                    ),
                    name: "Notifications",
                    isNoti: true,
                    handler: () {
                      Navigator.of(context).pushNamed(Homepage.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MoreCard(
                    image: Image.asset(
                      "images/mail.png",
                    ),
                    name: "Inbox",
                    handler: () {
                      Navigator.of(context).pushNamed(Homepage.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MoreCard(
                    image: Image.asset(
                      "images/info.png",
                    ),
                    name: "About Us",
                    handler: () {
                      Navigator.of(context).pushNamed(Homepage.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}

class MoreCard extends StatelessWidget {
  const MoreCard({
    Key key,
    String name,
    Image image,
    bool isNoti = false,
    Function handler,
  })  : _name = name,
        _image = image,
        _isNoti = isNoti,
        _handler = handler,
        super(key: key);

  final String _name;
  final Image _image;
  final bool _isNoti;
  final Function _handler;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handler,
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.only(
                right: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: AppColor.placeholderBg,
              ),
              child: Row(
                children: [
                  Container(
                      width: 50,
                      height: 50,
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: AppColor.placeholder,
                      ),
                      child: _image),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    _name,
                    style: const TextStyle(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 30,
                width: 30,
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: AppColor.placeholderBg,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.secondary,
                  size: 17,
                ),
              ),
            ),
            if (_isNoti)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(
                    right: 50,
                  ),
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(),
                    color: Colors.red,
                  ),
                  child: const Center(
                    child: Text(
                      "15",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
