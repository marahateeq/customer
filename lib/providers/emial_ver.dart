import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:customertest/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

class Verfiy extends StatefulWidget {
  const Verfiy({Key key}) : super(key: key);

  @override
  State<Verfiy> createState() => _VerfiyState();
}

class _VerfiyState extends State<Verfiy> {
  bool value;
  // Widget call() {
  Future<void> _emver() async {
    await Provider.of<Auth>(context, listen: false).sendE();
    print('start');
    await Provider.of<Auth>(context, listen: false).userData();
    value = Provider.of<Auth>(context, listen: false).emailverified;

    try {
      if (value == false) {
        AwesomeDialog(
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.INFO,
          body: const Center(
            child: Text(
              'your email address not verified We send you a verfication Email, Please check your email! ',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          title: 'Verify',

          btnCancelOnPress: () async {
            await Provider.of<Auth>(context, listen: false)
                .logout()
                .whenComplete(() => Phoenix.rebirth(context));
          },

          btnCancelColor: Colors.tealAccent,
          btnCancelText: "Log Out",
          //desc: 'This is also Ignored',
          // btnOkText: "Send Email",
          // btnOkOnPress: () async {
          //   print("ok pressed");
          //   await Provider.of<Auth>(context, listen: false)
          //       .logout()
          //       .whenComplete(() => Navigator.of(context)
          //           .pushNamedAndRemoveUntil(
          //               AuthSC.routeName, (route) => false));

          //   print("exit");
          // },
        ).show();
        // .then((value) =>   Navigator.of(context).pushNamedAndRemoveUntil(
        //             AuthSC.routeName, (route) => false));
        // } else if (value == true) {
        //   print("done");
        //   Navigator.of(context)
        //       .pushNamedAndRemoveUntil(Homepage.routeName, (route) => true);
      }
    } catch (e) {
      print("erorr while vervication");
      rethrow;
    }
  }

  // Widget awa(bool v) {
  //   try {
  //     if (v == false) {
  //       AppLifecycleState.paused;
  //       AwesomeDialog(
  //         dismissOnBackKeyPress: false,
  //         dismissOnTouchOutside: false,
  //         context: context,
  //         animType: AnimType.SCALE,
  //         dialogType: DialogType.INFO,
  //         body: const Center(
  //           child: Text(
  //             'your email address not verified , Please check your email! ',
  //             style: TextStyle(fontStyle: FontStyle.italic),
  //           ),
  //         ),
  //         title: 'Verify',
  //         btnCancelOnPress: () async {
  //           Provider.of<Auth>(context, listen: false).logout();
  //         },
  //         btnOkColor: Colors.teal,
  //         btnCancelColor: Colors.red,
  //         btnCancelText: "Exit",
  //         //desc: 'This is also Ignored',
  //         btnOkText: "ReSend",
  //         btnOkOnPress: () async {
  //           await Provider.of<Auth>(context, listen: false).sendE().then(
  //               (value) async =>
  //                   await Provider.of<Auth>(context, listen: false).logout());
  //         },
  //       ).show();
  //     } else if (v == true) {
  //       print("ok");
  //     }
  //   } catch (e) {
  //     print("erorr while vervication");
  //     rethrow;
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _emver();
  }

  @override
  Widget build(BuildContext context) {
    value = Provider.of<Auth>(context, listen: false).emailverified;

    print(value);
    print("object");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verfiy'),
          centerTitle: true,
        ),
        body: Container(
            // child: ElevatedButton.icon(
            //     onPressed: () {
            //     },
            //     icon: const Icon(Icons.logout),
            //     label: const Text("Log out")),
            // // child: const Center(child: Text("please vervif email")),
            ),
      ),
    );
  }
}
















// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:customertest/providers/auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// Future<void> emver() async {
//   BuildContext context;
//   await Provider.of<Auth>(context, listen: false).userData();
//   bool v = Provider.of<Auth>(context, listen: false).emailverified;
//   try {
//     if (v == false) {
//       AppLifecycleState.paused;
//       AwesomeDialog(
//         dismissOnBackKeyPress: false,
//         dismissOnTouchOutside: false,
//         context: context,
//         animType: AnimType.SCALE,
//         dialogType: DialogType.INFO,
//         body: const Center(
//           child: Text(
//             'your email address not verified , Please check your email! ',
//             style: TextStyle(fontStyle: FontStyle.italic),
//           ),
//         ),
//         title: 'Verify',

//         btnCancelOnPress: () async {
//           Provider.of<Auth>(context, listen: false).logout();
//         },
//         btnOkColor: Colors.teal,
//         btnCancelColor: Colors.red,
//         btnCancelText: "Exit",
//         //desc: 'This is also Ignored',
//         btnOkText: "ReSend",
//         btnOkOnPress: () async {
//           await Provider.of<Auth>(context, listen: false).sendE().then(
//               (value) async =>
//                   await Provider.of<Auth>(context, listen: false).logout());
//         },
//       ).show();
//     } else if (v == true) {
//       AppLifecycleState.resumed;
//     }
//   } catch (e) {
//     print("erorr while vervication");
//     rethrow;
//   }
// }


