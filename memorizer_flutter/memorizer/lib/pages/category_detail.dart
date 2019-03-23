import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memorizer/models/category_content.dart';
import 'package:memorizer/models/species_item.dart';
import 'package:memorizer/pages/gallery.dart';
import 'package:memorizer/pages/practice_confirm.dart';
import 'package:memorizer/pages/species_detail.dart';
import 'package:memorizer/utils/style.dart';
import 'package:memorizer/widgets/bottom_gradient.dart';
import 'package:memorizer/widgets/species_item.dart';

class CategoryDetailPage extends StatefulWidget {
  final CategoryContent category;

  CategoryDetailPage(this.category);

  @override
  _CategoryDetailPageState createState() => new _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  double _sliderValue = 10.0;
  bool _visible = false;

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
        gradient: new LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.grey[800],
            Colors.grey[700],
            Colors.grey[600],
            Colors.grey[400],
          ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          _buildImage(),
          BottomGradient(height: 500),
          new Padding(
            padding: new EdgeInsets.symmetric(vertical: 132.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text(
                  widget.category.name.getString("cs"),
                  style: new TextStyle(fontSize: 32.0),
                ),
                new Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  child: new Text(widget.category.name.getString("la")),
                ),
                _buildButtonSection()
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _buildButtonSection() {
    return AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              textColor: Colors.white,
              color: Colors.red,
              child: new Text("PRACTICE"),
              onPressed: () => {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return PracticeConfirmPage(widget.category);
                    }))
                  },
            ),
            new FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              textColor: Colors.white,
              color: Colors.red,
              child: new Text("GALLERY"),
              onPressed: () => {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return GalleryPage(
                          title: widget.category.name.getString("cs"),
                          items: widget.category.items);
                    }))
                  },
            ),
          ],
        ));
  }

  void updateSlider(double newRating) {
    setState(() => _sliderValue = newRating);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: defaultBgr,
        body: CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(),
            _buildContentSection(),
          ],
        ));
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 390.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text("Mojo"),
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

  void _navigateToDetail(SpeciesItem item) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return SpeciesDetail(item: item); // todo ret
    }));
  }
}
