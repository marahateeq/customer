import 'package:customertest/providers/info.dart';
import 'package:customertest/providers/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Homepage.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key key}) : super(key: key);
  static const routeName = '/UserInformation';
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final _fnameFocusNode = FocusNode();
  final _lnameFocusNode = FocusNode();
  final _mNumberFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();

  var _newUI = Info(
      // in case you want to modify the product values
      id: null,
      fname: '',
      lname: '',
      number: '',
      address: '',
      email: '');
  var _initialValues = {
    'fname': '',
    'lname': '',
    'number': '',
    'address': '',
    'email': '',
  };

  var _isInit = true;
  var _isLoading = false;

  @override // إعادة البناء في كل مرة يحدث فيها تحديث داخل البيانات التي تحضرها

  void didChangeDependencies() {
    // rebuild every time an update happens inside data that you bring
    // run only one time تنفيذ مرة واحدة فقط
    super.didChangeDependencies();
    if (_isInit) {
      // if _isInit == true
      final uId = ModalRoute.of(context).settings.arguments as String;

      if (uId != null) {
        // update
        _newUI = Provider.of<UserInfo>(context, listen: false).findById(uId);
        _initialValues = {
          'fname': _newUI.fname,
          'lname': _newUI.lname,
          'number': _newUI.number,
          'address': _newUI.address,
          'email': _newUI.email,
        };
      }
      _isInit = false;
    }
  }

  @override
  void dispose() {
    // distroy variables
    super.dispose();
    _fnameFocusNode.dispose();
    _lnameFocusNode.dispose();
    _mNumberFocusNode.dispose();
    _addressFocusNode.dispose();
    _emailFocusNode.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _formkey.currentState.validate(); // false or true
    if (!isValid) {
      // false
      return;
    }
    _formkey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_newUI.id != null) {
      await Provider.of<UserInfo>(context, listen: false)
          .updateUI(_newUI.id, _newUI);
    } else {
      try {
        await Provider.of<UserInfo>(context, listen: false).addUI(_newUI);
      } catch (e) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('An error occured'),
                  content: const Text('Something went wrong!'),
                  actions: [
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ));
      }
    }
    setState(() {
      _isLoading = false;
    });
    //Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(
      Homepage.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    //final email =    ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('User Information'),
        actions: [
          IconButton(
              onPressed: _saveForm,
              //Navigator.of(context).pushReplacementNamed(Homepage.routeName);
              // },
              icon: const Icon(Icons.save)),
        ],
      ),

      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),

              Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  style: const TextStyle(color: Colors.blue),
                  decoration: InputDecoration(

                      //fillColor: Colors.lightGreen,
                      //filled: true,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      labelText: "First Name",
                      labelStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      hintText: "Enter your first name",
                      hintStyle: const TextStyle(fontSize: 15),
                      icon: const Icon(
                        Icons.person,
                        color: Colors.pink,
                      )),
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_lnameFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _newUI = Info(
                      id: _newUI.id,
                      fname: value,
                      lname: _newUI.lname,
                      number: _newUI.number,
                      address: _newUI.number,
                      email: _newUI.email,
                    );
                  },
                ),
              ), //first name

              Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      labelText: "Family Name",
                      labelStyle: const TextStyle(fontSize: 20),
                      hintText: "Enter your family name",
                      hintStyle: const TextStyle(fontSize: 15),
                      icon: const Icon(
                        Icons.person,
                        color: Colors.pink,
                      )),
                  keyboardType: TextInputType.text,
                  focusNode: _lnameFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_emailFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _newUI = Info(
                      id: _newUI.id,
                      fname: _newUI.fname,
                      lname: value,
                      number: _newUI.number,
                      address: _newUI.number,
                      email: _newUI.email,
                    );
                  },
                ),
              ), //family name

              Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      labelText: "Email",
                      labelStyle: const TextStyle(fontSize: 20),
                      hintText: "your email",
                      hintStyle: const TextStyle(fontSize: 15),
                      icon: const Icon(
                        Icons.alternate_email,
                        color: Colors.pink,
                      )),
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _emailFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_mNumberFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _newUI = Info(
                      id: _newUI.id,
                      fname: _newUI.fname,
                      lname: _newUI.lname,
                      number: _newUI.number,
                      address: _newUI.number,
                      email: value,
                    );
                  },
                ),
              ), //email

              Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      labelText: "Phone number",
                      labelStyle: const TextStyle(fontSize: 20),
                      hintText: "enter Phone number ",
                      hintStyle: const TextStyle(fontSize: 15),
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.pink,
                      )),
                  keyboardType: TextInputType.number,
                  focusNode: _mNumberFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_addressFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _newUI = Info(
                      id: _newUI.id,
                      fname: _newUI.fname,
                      lname: _newUI.lname,
                      number: value,
                      address: _newUI.number,
                      email: _newUI.email,
                    );
                  },
                ),
              ), //phone number

              Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      labelText: "Address",
                      labelStyle: const TextStyle(fontSize: 20),
                      hintText: "  ",
                      hintStyle: const TextStyle(fontSize: 15),
                      icon: const Icon(
                        Icons.home,
                        color: Colors.pink,
                      )),
                  keyboardType: TextInputType.text,
                  focusNode: _addressFocusNode,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _newUI = Info(
                      id: _newUI.id,
                      fname: _newUI.fname,
                      lname: _newUI.lname,
                      number: _newUI.number,
                      address: value,
                      email: _newUI.email,
                    );
                  },
                ),
              ), //address
            ],
          ),
        ),
      ),

      // bottomNavigationBar: CustomNavBar(),
    );
  } //build
}
