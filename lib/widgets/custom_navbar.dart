import 'package:clip_shadow/clip_shadow.dart';
import 'package:customertest/screens/Homepage.dart';
import 'package:customertest/screens/more_screen.dart';
import 'package:customertest/screens/product_overview_screen.dart';
import 'package:customertest/screens/profile.dart';
import 'package:customertest/screens/restaurants_screen.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../utils/helper.dart';

class CustomNavBar extends StatelessWidget {
  final bool home;
  final bool menu;
  final bool offer;
  final bool profile;
  final bool more;

  const CustomNavBar(
      {Key key,
      this.home = false,
      this.menu = false,
      this.offer = false,
      this.profile = false,
      this.more = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: Helper.getScreenWidth(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipShadow(
              boxShadow: const [
                BoxShadow(
                  color: AppColor.placeholder,
                  offset: Offset(
                    0,
                    -5,
                  ),
                  blurRadius: 10,
                ),
              ],
              clipper: CustomNavBarClipper(),
              child: Container(
                height: 80,
                width: Helper.getScreenWidth(context),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!menu) {
                          Navigator.of(context).pushReplacementNamed(
                              ProductOverviewScreen.routeName);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          menu
                              ? const Icon(Icons.fastfood)
                              : const Icon(Icons.fastfood),
                          menu
                              ? const Text("Meals",
                                  style: TextStyle(color: AppColor.orange))
                              : const Text("Meals"),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!offer) {
                          Navigator.of(context).pushReplacementNamed(
                              RestaurantsScreen.routeName);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          offer
                              ? const Icon(Icons.restaurant)
                              : const Icon(Icons.restaurant),
                          offer
                              ? const Text("Restaurants",
                                  style: TextStyle(color: AppColor.orange))
                              : const Text("Restaurants"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!profile) {
                          Navigator.of(context)
                              .pushReplacementNamed(Profile.routeName);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          profile
                              ? const Icon(Icons.person)
                              : const Icon(Icons.person),
                          profile
                              ? const Text("Profile",
                                  style: TextStyle(color: AppColor.orange))
                              : const Text("Profile"),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!more) {
                          Navigator.of(context)
                              .pushReplacementNamed(MoreScreen.routeName);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          more
                              ? const Icon(Icons.more_vert)
                              : const Icon(Icons.more_vert),
                          more
                              ? const Text("Profile",
                                  style: TextStyle(color: AppColor.orange))
                              : const Text("More"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 70,
              width: 70,
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors
                    .deepOrange, //home ? AppColor.orange : AppColor.placeholder,
                onPressed: () {
                  if (!home) {
                    Navigator.of(context)
                        .pushReplacementNamed(Homepage.routeName);
                  }
                },
                child: const Icon(Icons.home),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(
      size.width * 0.375,
      0,
      size.width * 0.375,
      size.height * 0.1,
    );
    path.cubicTo(
      size.width * 0.4,
      size.height * 0.9,
      size.width * 0.6,
      size.height * 0.9,
      size.width * 0.625,
      size.height * 0.1,
    );
    path.quadraticBezierTo(
      size.width * 0.625,
      0,
      size.width * 0.7,
      0.1,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
