import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;

  ImageList(this.images);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return buildImage(images[index]);
        });
  }

  Widget buildImage(ImageModel imageModel) {
    return Container(
      child: Column(
          children: [
            Padding(
              child: Image.network(imageModel.url),
              padding: EdgeInsets.only(bottom: 8.0)
            ),
            Text(imageModel.title)
          ]
      ),
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
    );
  }
}
