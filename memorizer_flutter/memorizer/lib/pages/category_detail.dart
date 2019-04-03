import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memorizer/entities/category_content.dart';
import 'package:memorizer/entities/species_item.dart';
import 'package:memorizer/pages/gallery.dart';
import 'package:memorizer/pages/practice_confirm.dart';
import 'package:memorizer/pages/species_detail.dart';
import 'package:memorizer/utils/shared_preferences.dart';
import 'package:memorizer/utils/style.dart';
import 'package:memorizer/widgets/bottom_gradient.dart';
import 'package:memorizer/widgets/species_item.dart';
import 'package:sliver_fab/sliver_fab.dart';

class CategoryDetailPage extends StatefulWidget {
  final CategoryContent category;

  CategoryDetailPage(this.category);

  @override
  _CategoryDetailPageState createState() => new _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  double _sliderValue = 10.0;
  bool _visible = false;
  String langCode;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), () => setState(() => _visible = true));
  }


  Widget _buildImage() {
    return new Hero(
      tag: widget.category.items.first.imageUrl,
      child: new Container(
        constraints: new BoxConstraints(),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new NetworkImage(widget.category.items.first.imageUrl ?? ''),
          ),
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return new Container(
      decoration: new BoxDecoration(
        gradient: detailGradient,
      ),
      child: Stack(
        children: <Widget>[
          _buildImage(),
          BottomGradient(height: 500),
        ],
      )
    );
  }

  void updateSlider(double newRating) {
    setState(() => _sliderValue = newRating);
  }

  @override
  Widget build(BuildContext context) {
    return new SharedPreferencesBuilder(
        pref: PREF_LANG_CODE,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          langCode = snapshot.data;
          return new Scaffold(
            backgroundColor: defaultBgr,
            body: new Builder(
              builder: (context) =>
              new SliverFab(
                floatingWidget: FloatingActionButton(
                  backgroundColor: Color.fromRGBO(247, 64, 106, 1.0),
                  onPressed: () { _navigateToPractice(); },
                  child: Image.asset("assets/ic_practice.png"),
                ),
                floatingPosition: FloatingPosition(right: 16),
                expandedHeight: 360.0,
                slivers: <Widget>[
                  _buildAppBar(),
                  _buildContentSection()
                ],
              ),
            ),
          );
        });
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      actions: <Widget>[
     AnimatedOpacity(
    opacity: _visible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: new Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.list),
                onPressed: () { _navigateToGallery(); })
          ],
        ))
      ],
      expandedHeight: 390.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: new Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(
              widget.category.name.getString(langCode),
              style: new TextStyle(fontSize: 20.0),
            ),
            langCode == "la" ? Container() :
            new Container(
              margin: const EdgeInsets.only(left: 10.0, bottom: 3.0),
                child: new Text("(${widget.category.name.getString("la")})",
                    style: new TextStyle(fontSize: 10))
            ),
          ],
        ),
        background: _buildHeading(),
      ),
    );
  }

  Widget _buildContentSection() {
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        ListView.builder(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.category.items.length,
          itemBuilder: (BuildContext context, int index) {
            return new SpeciesItemWidget(
                item: widget.category.items[index],
                onPressed: () =>
                    _navigateToDetail(widget.category.items[index]));
          },
        )
      ]),
    );
  }

  void _navigateToGallery() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) {
          return GalleryPage(
              title: widget.category.name.getString(langCode),
              items: widget.category.items);
        }));
  }

  void _navigateToPractice() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) {
          return PracticeConfirmPage(widget.category);
        }));
  }

  void _navigateToDetail(SpeciesItem item) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return SpeciesDetail(item: item); // todo ret
    }));
  }
}
