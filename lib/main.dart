import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  String _response;

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
            RaisedButton(
              child: Text("GET"),
              onPressed: _get,
            ),
            Divider(),
            RaisedButton(
              child: Text("POST"),
              onPressed: _post,
            ),
            Divider(),
            RaisedButton(
              child: Text("PUT"),
              onPressed: _put,
            ),
            Divider(),
            RaisedButton(
              child: Text("DELETE"),
              onPressed: _delete,
            ),
            Divider(),
            Text(
              '$_response',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }

  void _get() async {
    var url = "https://jsonplaceholder.typicode.com/posts/1";

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse["title"]);
      setState(() {
        _response = jsonResponse["title"];
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void _post() async {
    var url = "https://jsonplaceholder.typicode.com/posts";

    var response = await http
        .post(url, body: {"title": "foo", "body": "bar", "userId": "11"});
    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void _put() async {
    var url = "https://jsonplaceholder.typicode.com/posts/1";

    var response = await http
        .put(url, body: {"title": "foo", "body": "bar", "userId": "1"});

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void _delete() async {
    var url = "https://jsonplaceholder.typicode.com/posts/1";

    var response = await http.delete(url);

    if (response.statusCode == 200) {
      print("Resource deleted");
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
