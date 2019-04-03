import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:memorizer/entities/species_item.dart';
import 'package:memorizer/utils/shared_preferences.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key, this.title, this.items}) : super(key: key);

  final String title;
  List<SpeciesItem> items;

  @override
  _GalleryState createState() => new _GalleryState();
}

class _GalleryState extends State<GalleryPage> {
  String langCode;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new SharedPreferencesBuilder(
        pref: PREF_LANG_CODE,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          langCode = snapshot.data;
          return new Scaffold(
              backgroundColor: Colors.black,
              body: OrientationBuilder(
                builder: (context, orientation) {
                  return _buildContent(orientation);
                },
              ));
        });
  }

  Widget _buildContent(Orientation orientation) {
    return Stack(children: <Widget>[
      Swiper(
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImage(
              imageUrl: widget.items[index].imageUrls.first,
              fit: BoxFit.cover
            );
          },
          itemCount: widget.items.length,
          control: new SwiperControl(color: Colors.redAccent),
          itemWidth: orientation == Orientation.landscape
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.height,
          itemHeight: orientation == Orientation.landscape
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.width,
          layout: SwiperLayout.TINDER,
          onIndexChanged: ((idx) {
            setState(() { currentIndex = idx;});
          })),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 130.0),
                  child: Text(widget.items[currentIndex].name
                      .getString(langCode),
                  style: TextStyle(fontSize: 20),)))
        ],
      )
    ]);
  }
}
