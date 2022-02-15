import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import 'checkOut.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';

  const CartScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text('₪${cart.totalAmount.toStringAsFixed(2)}'),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  // OrderButton(
                  //   cart : cart
                  //),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (BuildContext context, int index) => CartItem(
                cart.items.values.toList()[index].restId,
                cart.items.keys.toList()[index],
                cart.items.values.toList()[index].price,
                cart.items.values.toList()[index].quantity,
                cart.items.values.toList()[index].title),
          )),
          Card(
            margin: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OrderButton(cart: cart),
                  // OrderButton(
                  //   cart : cart
                  //),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final Cart cart;

  const OrderButton({
    @required this.cart,
  });

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  final int _qty = 0;
  String q = '0';

  String numberPeople = " ";
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);
  DateTime _date = DateTime.now();

  bool delivery;

  final _formkey = GlobalKey<FormState>();
  final _mNumberFocusNode = FocusNode();
  final _text = TextEditingController();

  bool _isloading = false;

  Map map = {
    'time': const TimeOfDay(hour: 7, minute: 15),
    'date': DateTime.now(),
    'numberPeople': 0,
    'delivery': null,
  };
  @override
  Widget build(BuildContext context) {
    final ds = MediaQuery.of(context).size;
    return TextButton(
      child: _isloading
          ? const CircularProgressIndicator()
          : const Text(
              "Order now",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
      onPressed: (widget.cart.totalAmount <= 0 || _isloading)
          ? null
          : () async {
              setState(() {
                _isloading = true;
              });

              //Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Select ? '),
                      content: const Text('Select the type of your order ?'),
                      elevation: 24.0,
                      actions: [
                        TextButton(
                          child: const Text(
                            'Delivery',
                            style: TextStyle(
                                fontSize: 20 //color: Colors.deepOrange
                                ),
                          ),
                          onPressed: () async {
                            map['delivery'] = true;

                            return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      insetPadding: const EdgeInsets.all(10),
                                      child: dialogdelivery(context, ds));
                                });
                          },
                        ),
                        TextButton(
                          child: const Text('Reserve a table',
                              style: TextStyle(fontSize: 20)),
                          onPressed: () async {
                            map['delivery'] = false;

                            return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      insetPadding: const EdgeInsets.all(10),
                                      child: dialogReserve(context, ds));
                                });

                            /* await Provider.of<Orders>(context , listen: false).addOrders(

                          widget.cart.items.values.toList(),
                          widget.cart.totalAmount,
                          false,

                        );
                        setState(() {
                          _isloading = false;

                        });

                        Navigator.of(context).pushReplacementNamed(ReservationInfo.routeName);*/
                          },
                        ),
                      ],
                    );
                  });
              widget.cart.clear();
            },
    );
  }

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        map['time'] = _time;
      });
    }
  }

  void _selectDate() async {
    DateTime newDate = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: _date,
        lastDate: DateTime(_date.year, _date.month, _date.day + 7));
    if (newDate != null) {
      setState(() {
        _date = newDate;
        map['date'] = newDate;
      });
    }

    _date = DateTime.now();
  }

  Future<void> _saveForm() async {
    final isValid = _formkey.currentState.validate(); // false or true
    if (!isValid) {
      // false
      return;
    }
    _formkey.currentState.save();

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const CheckOut(),
        settings: RouteSettings(arguments: map)));
  }

  Widget dialogdelivery(BuildContext context, final ds) {
    return Container(
      height: ds.height * 0.66,
      width: ds.width * 0.75,
      padding: const EdgeInsets.all(25),
      child: Form(
        key: _formkey,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _selectTime,
                child: const Text('SELECT TIME'),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: _selectDate,
                child: const Text('SELECT DATE'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed(
                      CartScreen.routeName,
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () => _saveForm(),
                    child: const Text('Ok'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dialogReserve(BuildContext context, final ds) {
    return Container(
      height: ds.height * 0.66,
      width: ds.width * 0.75,
      padding: const EdgeInsets.all(25),
      child: Form(
        key: _formkey,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _selectTime,
                child: const Text('SELECT TIME'),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: _selectDate,
                child: const Text('SELECT DATE'),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text('ENTER NUMBER OF PEOPLE'),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    labelText: "Number",
                    labelStyle: const TextStyle(fontSize: 20),
                    hintText: "enter number of people ",
                    hintStyle: const TextStyle(fontSize: 15),
                    icon: const Icon(
                      Icons.person,
                      color: Colors.pink,
                    )),
                keyboardType: TextInputType.number,
                controller: _text,
                focusNode: _mNumberFocusNode,
                enableInteractiveSelection: false,
                toolbarOptions: const ToolbarOptions(
                  copy: false,
                  paste: false,
                  selectAll: false,
                  cut: false,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value';
                  }
                },
                onSaved: (value) {
                  numberPeople = value;
                  map['numberPeople'] = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed(
                      CartScreen.routeName,
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () => _saveForm(),
                    child: const Text('Ok'),
                  ),
                ],
              ),

              /* Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[100],
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1))
                      ],
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.minus,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_qty != 0) {
                            _qty = _qty - 1;
                            q = _qty.toString();
                          }
                        });
                        print(q);
                      }
                      )
              ),

              Padding(
                  padding: EdgeInsets.all(10.0),
                  child:
                  Text( q.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                  )),

              Container(
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[100],
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1))
                      ],
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.plus,
                        color: Colors.white,
                      ),
                      onPressed: () {

                        setState(() {
                          _qty = _qty + 1;
                          q = _qty.toString();
                        });
                        print(q);

                      })),
            ],
          )*/
            ],
          ),
        ),
      ),
    );
  }
}
