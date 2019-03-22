import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memorizer/blocs/bloc_provider.dart';
import 'package:memorizer/models/category_content.dart';
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

  @override
  void initState() {
    super.initState();
    _createBloc();
  }

  ///
  /// As Widgets can be changed by the framework at any time,
  /// we need to make sure that if this happens, we keep on
  /// listening to the stream that notifies us about favorites
  ///
  @override
  void didUpdateWidget(CategoryCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disposeBloc();
    _createBloc();
  }

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  void _createBloc() {

  }

  void _disposeBloc() {

  }

  @override
  Widget build(BuildContext context) {
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
          categoryCard.name.getString("cs"),
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
