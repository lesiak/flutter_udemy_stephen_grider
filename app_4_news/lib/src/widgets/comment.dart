import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;

  final Map<int, Future<ItemModel>> itemMap;

  final int depth;

  const Comment({Key key, this.itemId, this.itemMap, this.depth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return Text('Still loading comment');
        }

        var item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: buildText(item),
            subtitle: item.by != null ? Text(item.by) : Text('deleted'),
            contentPadding: EdgeInsets.only(right: 16.0, left: 16.0 * depth),
          ),
          Divider(),
        ];
        item.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth + 1,
          ));
        });
        return Column(
          children: children,
        );
      },
    );
  }

  Text buildText(ItemModel item) {
    final text = item.text
        .replaceAll('&#x27;', "'")
        .replaceAll('&gt;', '>')
        .replaceAll('&lt;', '<')
        .replaceAll('<p>', '\n\n');

    return Text(text);
  }
}
