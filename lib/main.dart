import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Transfer App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Money Transfer App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var id, firstName, lastName, phoneNumber, email, balance;

  void apiCall() async {
    var url = Uri.https(
        "money-transfer-api-act.herokuapp.com", "/api/account/show/1");

    var response = await http.get(url);

    var jsonResponse = convert.jsonDecode(response.body);

    print(jsonResponse);

    setState(() {
      id = jsonResponse['id'];
      firstName = jsonResponse['firstName'];
      lastName = jsonResponse['lastName'];
      phoneNumber = jsonResponse['phoneNumber'];
      email = jsonResponse['email'];
      balance = jsonResponse['balance'];
    });
  }

  @override
  void initState() {
    super.initState();
    apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Show Account',
            ),
            Text(
              'First Name $firstName',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              'Last Name $lastName',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              'Phone Number $phoneNumber',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Email $email',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Balance $balance',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
