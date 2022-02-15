
import 'package:customertest/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';

import 'Homepage.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);
  static const routeName = '/profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var selectedRes;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('Your Profile'),
        actions: [
          IconButton(
              onPressed: () {
                //_saveForm;
                Navigator.of(context).pushReplacementNamed(Homepage.routeName);
              },
              icon: const Icon(Icons.save)),
        ],
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),

                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextField(
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
                    onChanged: (_) {},
                  ),
                ), //first name

                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextField(
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
                  ),
                ), //family name

                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextField(
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
                  ),
                ), //email

                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextField(
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
                  ),
                ), //phone number

                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextField(
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
                  ),
                ), //address

                Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrangeAccent),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "updata personal information",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),

      //body:
      /*StreamBuilder(
           stream: usersref.snapshots(),
           builder: (context,snapshot)
           {
             if (snapshot.hasError) {
               return Text("Error");
             }
             if (snapshot.connectionState == ConnectionState.waiting) {
               return Text("Loading.........");
             }
             if (snapshot.hasData) {
               return ListView.builder(
//               itemCount : snapshot.data.docs.length,
                   itemBuilder: (context, i) {
                     return Text("aaaaaaaaaaaaaaaaaaggg");
                   }

               );
             }
           }),*/
      /* body: Center(
        child: Container(
          color: Colors.white70,
          child: DropdownButton(
            hint: const Text(
              "قائمة المطاعم",
              style: TextStyle(color: Colors.black),
            ),
            icon: const Icon(
              Icons.restaurant,
              color: Colors.deepOrangeAccent,
              textDirection: TextDirection.rtl,
            ),
            items: ["Halab", "Fairoz", "Popayes", "maarah", "adam"]
                .map((e) => DropdownMenuItem(child: Text(e), value: e))
                .toList(),
            onChanged: (val) {
              setState(() {
                selectedRes = val;
                Navigator.of(context).pushReplacementNamed("homepage");
                // المفروض اختار المطعم اللي بدي ويروح يوخدني على المنيو تبعته (صفحة شخصية للمطعم)
              });
            },
            value: selectedRes,
          ),
        ),
      ),*/

      bottomNavigationBar: const CustomNavBar(),
    );
  } //build

} //class

// the end //