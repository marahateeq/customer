import 'dart:convert';

import 'package:customertest/providers/user_info.dart';
import 'package:customertest/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';

class Profile extends StatefulWidget {
  static const routeName = "/profile";

  const Profile({Key key}) : super(key: key);

  //final rest =await Provider.of<Restaurants>(context).fetchRestaurant();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> getData() async {
    await Provider.of<UserInfo>(context, listen: false).getUinfo();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Map m;
  @override
  void initState() {
    getData();

    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  @override
  Widget build(BuildContext context) {
    m = Provider.of<UserInfo>(context, listen: false).data;
    String mn = m['fname'];
    // print(m); // final emaild = Provider.of<Auth>(context, listen: false);
    // final uemail = emaild.emaildata;
    //final restaurant =
    // final rest = Provider.of<Restaurants>(context, listen: false).rest;

    // final _restaurant = ModalRoute.of(context).settings.arguments as Restaurant;

    return Scaffold(
      appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
          leading:
              BackButton(onPressed: () => Navigator.of(context).maybePop())),
      body: m == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SafeArea(
                  child: SizedBox(
                    height: Helper.getScreenHeight(context),
                    width: Helper.getScreenWidth(context),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            ClipOval(
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Image.network(
                                        'https://api.multiavatar.com/$mn.png'),
                                  ),
                                  // Positioned(
                                  //   bottom: 0,
                                  //   child: Container(
                                  //     height: 30,
                                  //     width: 150,
                                  //     color: Colors.black.withOpacity(0.6),
                                  //     child: Image.asset("images/camera.png"),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.edit, //color: Colors.deepOrange,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  child: const Text(
                                    "Edit Profile",
                                    style: TextStyle(color: AppColor.orange),
                                  ),
                                  // onTap: () => Navigator.of(context)
                                  //     .pushNamed(),
                                ),
                              ],
                            ),
                            // const Center(
                            //   child: Text('Your profile'),
                            // ),
                            const SizedBox(
                              height: 40,
                            ),
                            CustomFormImput(
                              label: "Name",
                              value: (" ${m['fname']} ${m['lname']}"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomFormImput(
                              label: "Email",
                              value: m['email'],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomFormImput(
                              label: "Mobile No",
                              value: m['number'],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomFormImput(
                              label: "Address",
                              value: m['address'],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // const CustomFormImput(
                            //   label: "Password",
                            //   value: "Emilia Clarke",
                            //   isPassword: true,
                            // ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            // const CustomFormImput(
                            //   label: "Confirm Password",
                            //   value: "Emilia Clarke",
                            //   isPassword: true,
                            // ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Back"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class CustomFormImput extends StatelessWidget {
  const CustomFormImput({
    Key key,
    String label,
    String value,
    bool isPassword = false,
  })  : _label = label,
        _value = value,
        _isPassword = isPassword,
        super(key: key);

  final String _label;
  final String _value;
  final bool _isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 40),
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: AppColor.placeholderBg,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: _label,
          contentPadding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
        ),
        obscureText: _isPassword,
        initialValue: _value,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}




// import 'package:customertest/widgets/custom_navbar.dart';
// import 'package:flutter/material.dart';

// import 'Homepage.dart';

// class Profile extends StatefulWidget {
//   const Profile({Key key}) : super(key: key);
//   static const routeName = '/profile';
//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     var selectedRes;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepOrange,
//         title: const Text('Your Profile'),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 //_saveForm;
//                 Navigator.of(context).pushReplacementNamed(Homepage.routeName);
//               },
//               icon: const Icon(Icons.save)),
//         ],
//       ),

//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),

//                 Container(
//                   margin: const EdgeInsets.all(20),
//                   child: TextField(
//                     style: const TextStyle(color: Colors.blue),
//                     decoration: InputDecoration(

//                         //fillColor: Colors.lightGreen,
//                         //filled: true,
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(width: 2),
//                           borderRadius: BorderRadius.circular(4.0),
//                         ),
//                         labelText: "First Name",
//                         labelStyle: const TextStyle(
//                           fontSize: 20,
//                         ),
//                         hintText: "Enter your first name",
//                         hintStyle: const TextStyle(fontSize: 15),
//                         icon: const Icon(
//                           Icons.person,
//                           color: Colors.pink,
//                         )),
//                     keyboardType: TextInputType.text,
//                     onChanged: (_) {},
//                   ),
//                 ), //first name

//                 Container(
//                   margin: const EdgeInsets.all(20),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(width: 2),
//                           borderRadius: BorderRadius.circular(4.0),
//                         ),
//                         labelText: "Family Name",
//                         labelStyle: const TextStyle(fontSize: 20),
//                         hintText: "Enter your family name",
//                         hintStyle: const TextStyle(fontSize: 15),
//                         icon: const Icon(
//                           Icons.person,
//                           color: Colors.pink,
//                         )),
//                     keyboardType: TextInputType.text,
//                   ),
//                 ), //family name

//                 Container(
//                   margin: const EdgeInsets.all(20),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(width: 2),
//                           borderRadius: BorderRadius.circular(4.0),
//                         ),
//                         labelText: "Email",
//                         labelStyle: const TextStyle(fontSize: 20),
//                         hintText: "your email",
//                         hintStyle: const TextStyle(fontSize: 15),
//                         icon: const Icon(
//                           Icons.alternate_email,
//                           color: Colors.pink,
//                         )),
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                 ), //email

//                 Container(
//                   margin: const EdgeInsets.all(20),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(width: 2),
//                           borderRadius: BorderRadius.circular(4.0),
//                         ),
//                         labelText: "Phone number",
//                         labelStyle: const TextStyle(fontSize: 20),
//                         hintText: "enter Phone number ",
//                         hintStyle: const TextStyle(fontSize: 15),
//                         icon: const Icon(
//                           Icons.phone,
//                           color: Colors.pink,
//                         )),
//                     keyboardType: TextInputType.number,
//                   ),
//                 ), //phone number

//                 Container(
//                   margin: const EdgeInsets.all(20),
//                   child: TextField(
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(width: 2),
//                           borderRadius: BorderRadius.circular(4.0),
//                         ),
//                         labelText: "Address",
//                         labelStyle: const TextStyle(fontSize: 20),
//                         hintText: "  ",
//                         hintStyle: const TextStyle(fontSize: 15),
//                         icon: const Icon(
//                           Icons.home,
//                           color: Colors.pink,
//                         )),
//                     keyboardType: TextInputType.text,
//                   ),
//                 ), //address

//                 Container(
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.all(Colors.deepOrangeAccent),
//                     ),
//                     onPressed: () {},
//                     child: const Text(
//                       "updata personal information",
//                       style: TextStyle(color: Colors.black, fontSize: 18),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),

//       //body:
//       /*StreamBuilder(
//            stream: usersref.snapshots(),
//            builder: (context,snapshot)
//            {
//              if (snapshot.hasError) {
//                return Text("Error");
//              }
//              if (snapshot.connectionState == ConnectionState.waiting) {
//                return Text("Loading.........");
//              }
//              if (snapshot.hasData) {
//                return ListView.builder(
// //               itemCount : snapshot.data.docs.length,
//                    itemBuilder: (context, i) {
//                      return Text("aaaaaaaaaaaaaaaaaaggg");
//                    }

//                );
//              }
//            }),*/
//       /* body: Center(
//         child: Container(
//           color: Colors.white70,
//           child: DropdownButton(
//             hint: const Text(
//               "قائمة المطاعم",
//               style: TextStyle(color: Colors.black),
//             ),
//             icon: const Icon(
//               Icons.restaurant,
//               color: Colors.deepOrangeAccent,
//               textDirection: TextDirection.rtl,
//             ),
//             items: ["Halab", "Fairoz", "Popayes", "maarah", "adam"]
//                 .map((e) => DropdownMenuItem(child: Text(e), value: e))
//                 .toList(),
//             onChanged: (val) {
//               setState(() {
//                 selectedRes = val;
//                 Navigator.of(context).pushReplacementNamed("homepage");
//                 // المفروض اختار المطعم اللي بدي ويروح يوخدني على المنيو تبعته (صفحة شخصية للمطعم)
//               });
//             },
//             value: selectedRes,
//           ),
//         ),
//       ),*/

//       bottomNavigationBar: const CustomNavBar(),
//     );
//   } //build

// } //class

// // the end //