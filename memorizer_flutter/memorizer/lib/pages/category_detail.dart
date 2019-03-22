import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memorizer/models/category_content.dart';
import 'package:memorizer/models/species_item.dart';
import 'package:memorizer/pages/practice_confirm.dart';
import 'package:memorizer/pages/species_detail.dart';
import 'package:memorizer/widgets/bottom_gradient.dart';
import 'package:memorizer/widgets/species_item.dart';

class CategoryDetailPage extends StatefulWidget {
  final CategoryContent category;

  CategoryDetailPage(this.category);

  @override
  _CategoryDetailPageState createState() => new _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  double dogAvatarSize = 150.0;
  double _sliderValue = 10.0;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 100), () => setState(() => _visible = true));
  }

  Widget get dogImage {
    return new Hero(
      tag: widget.category.name.getString("cs"),
      child: new Container(
        height: dogAvatarSize,
        width: dogAvatarSize,
        constraints: new BoxConstraints(),
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            const BoxShadow(
                offset: const Offset(1.0, 2.0),
                blurRadius: 2.0,
                spreadRadius: -1.0,
                color: const Color(0x33000000)),
            const BoxShadow(
                offset: const Offset(2.0, 1.0),
                blurRadius: 3.0,
                spreadRadius: 0.0,
                color: const Color(0x24000000)),
            const BoxShadow(
                offset: const Offset(3.0, 1.0),
                blurRadius: 4.0,
                spreadRadius: 2.0,
                color: const Color(0x1F000000)),
          ],
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new NetworkImage(widget.category.items.first.imageUrl ?? ''),
          ),
        ),
      ),
    );
  }

  Widget get dogProfile {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 32.0),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.indigo[800],
            Colors.indigo[700],
            Colors.indigo[600],
            Colors.indigo[400],
          ],
        ),
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          dogImage,
          new Text(
            widget.category.name.getString("cs") + '  🎾',
            style: new TextStyle(fontSize: 32.0),
          ),
          new Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: new Text(widget.category.name.getString("la")),
          ),
          rating
        ],
      ),
    );
  }

  Widget get rating {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(
          Icons.star,
          size: 40.0,
        ),
      ],
    );
  }

  Widget get addYourRating {
    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Flexible(
                flex: 1,
                child: new Slider(
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 15.0,
                  onChanged: (newRating) => updateSlider(newRating),
                  value: _sliderValue,
                ),
              ),
              new Container(
                width: 50.0,
                alignment: Alignment.center,
                child: new Text('${_sliderValue.toInt()}',
                    style: Theme.of(context).textTheme.display1),
              ),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  Widget get submitRatingButton {
    return new RaisedButton(
      child: new Text('Submit'),
      onPressed: () => {
        Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
          return PracticeConfirmPage(widget.category);
        }))
      },
      color: Colors.indigoAccent,
    );
  }

  void updateSlider(double newRating) {
    setState(() => _sliderValue = newRating);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87,
        body: CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(),
            _buildContentSection(),
          ],
        ));
  }


  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 240.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            dogProfile,
            new BottomGradient(),
            _buildMetaSection()
          ],
        ),
      ),
    );
  }

  Widget _buildMetaSection() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
    );
  }

  Widget _buildContentSection() {
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        addYourRating,
        ListView.builder(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.category.items.length,
          itemBuilder: (BuildContext context, int index) {
          return new SpeciesItemWidget(
              item: widget.category.items[index],
              onPressed: () => navigateToDetail(widget.category.items[index]));
    },
    )
      ]),
    );
  }

  void navigateToDetail(SpeciesItem item){
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return SpeciesDetail(item: item); // todo ret
   }));
 }
}
