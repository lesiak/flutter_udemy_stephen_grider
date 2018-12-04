import 'package:flutter/material.dart';

class App extends StatefulWidget {

  @override
  State createState() => AppState();
}

class AppState extends State<App> {

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text("Let's see some images!")),
          body: Text('$counter'),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => setState(() => ++counter)
          )
        )
    );
  }


}

