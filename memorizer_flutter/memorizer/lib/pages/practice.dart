import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:memorizer/models/category_item.dart';

class Practice extends StatefulWidget {
  Practice({Key key, this.title, this.items}) : super(key: key);

  final String title;
  List<CategoryItem> items;

  @override
  _PracticeState createState() => new _PracticeState();
}

class _PracticeState extends State<Practice> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body:  new Swiper(
        itemBuilder: (BuildContext context, int index){
          return new Image.network(widget.items[index].imageUrls.first, fit: BoxFit.cover,);
        },
        itemCount: widget.items.length,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }
}