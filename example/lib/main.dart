import 'dart:convert';

import 'package:caching_package/caching_package.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final CacheHandler _cacheHandler = CacheHandler();

  final String NO_RESPONSE = "NO_VALUE";
  String dataString = "INITIAL VALUE";

  bool isLoading = false;

  _loading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  getFromAPI() async {
    String todosID = "1";
    _loading();
    Map<String, dynamic>? data = await _cacheHandler.cacheAPI(
        apiUrl: "https://jsonplaceholder.typicode.com/todos/${todosID}",
      cacheSettings: CacheSettings(enableCaching: true)
    );
    _loading();
    if (data != null) {
      setState(() {
        dataString = json.encode(data).toString();
      });
      return;
    }
    setState(() {
      dataString = NO_RESPONSE;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("cache_package"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isLoading
                ? Container(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  )
                : Text(dataString)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getFromAPI,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
