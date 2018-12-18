import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'models/image_model.dart';
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  @override
  State createState() => AppState();
}

class AppState extends State<App> {

  int counter = 0;
  List<ImageModel> images = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text("Let's see some images!")),
          body: ImageList(images),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: fetchImage
          )
        )
    );
  }

  void fetchImage() async {
    ++counter;
    var url = "https://jsonplaceholder.typicode.com/photos/$counter";
    var response = await get(url);
    var imageModel = ImageModel.fromJson(json.decode(response.body));
    setState(() => images.add(imageModel));
  }
}

