import 'package:customertest/const/colors.dart';

import 'package:flutter/material.dart';


import 'add_address.dart';

class Address extends StatefulWidget {
  const Address({Key key}) : super(key: key);
  static const routeName = '/address';
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    //final restaurant = Provider.of<Restaurant>(context , listen: false);

    //final _restaurant = ModalRoute.of(context).settings.arguments as Restaurant;
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Addresses "),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            width: 500,
            child: Image.asset(
              "images/vector3.png",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Center(
              child: Text(
            'Without addresses',
            style: TextStyle(fontSize: 30),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(AddAddress.routeName);
        },
      ),
      /*
      Stack(
        children: [
          SafeArea(
            child: Container(
              height: Helper.getScreenHeight(context),
              width: Helper.getScreenWidth(context),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [

                      SizedBox(
                        height: 20,
                      ),
                      ClipOval(
                        child: Stack(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              child: Image.asset("images/profile.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 30,
                                width: 150,
                                color: Colors.black.withOpacity(0.6),
                                child: Image.asset("images/camera.png"),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit , //color: Colors.deepOrange,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(color: AppColor.orange),
                            ),
                            onTap: () => Navigator.of(context).pushNamed(Homepage.routeName),
                          ),
                        ],
                      ),
                      Center(
                        child: Text('Your profile'),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CustomFormImput(
                        label: "Name",
                        value: "Emilia Clarke",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Email",
                        value: "emiliaclarke@email.com",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Mobile No",
                        value: "emiliaclarke@email.com",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Address",
                        value: "No 23, 6th Lane, Colombo 03",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Password",
                        value: "Emilia Clarke",
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormImput(
                        label: "Confirm Password",
                        value: "Emilia Clarke",
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Save"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),*/
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
