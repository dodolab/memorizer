import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memorizer/entities/category_content.dart';
import 'package:memorizer/utils/shared_preferences.dart';
import 'package:memorizer/utils/style.dart';

class CategoryCardWidget extends StatefulWidget {
  CategoryCardWidget({
    Key key,
    @required this.categoryContent,
    @required this.onPressed
  }) : super(key: key);

  final CategoryContent categoryContent;
  final VoidCallback onPressed;


  @override
  CategoryCardWidgetState createState() => CategoryCardWidgetState();
}

class CategoryCardWidgetState extends State<CategoryCardWidget> {

  String langCode;


  @override
  Widget build(BuildContext context) {
    return new SharedPreferencesBuilder(
        pref: PREF_LANG_CODE,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          langCode = snapshot.data;
          return _buildContent();
        });
  }

  Widget _buildContent() {
    List<Widget> children = <Widget>[
      ClipRect(
        clipper: SquareClipper(),
        child: Image.network(widget.categoryContent.items.first.imageUrls.first,
            fit: BoxFit.cover),
      ),
      Container(
        decoration: _buildGradientBackground(),
        padding: const EdgeInsets.only(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        child: _buildTextualInfo(widget.categoryContent),
      ),
    ];

    return InkWell(
      onTap: widget.onPressed,
      child: Card(
        child: Stack(
          fit: StackFit.expand,
          children: children,
        ),
      ),
    );
  }

  BoxDecoration _buildGradientBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: <double>[0.0, 0.7, 0.7],
        colors: <Color>[
          Colors.black,
          Colors.transparent,
          Colors.transparent,
        ],
      ),
    );
  }

  Widget _buildTextualInfo(CategoryContent categoryCard) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          categoryCard.name.getString(langCode),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
