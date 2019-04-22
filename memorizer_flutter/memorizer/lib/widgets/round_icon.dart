import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundIconWidget extends StatelessWidget {
  final String imageUrl;
  final bool useTag;

  RoundIconWidget(@required this.imageUrl, this.useTag);

  @override
  Widget build(BuildContext context) {
    var image = new Hero(
      tag: this.useTag ? this.imageUrl : this.imageUrl + "___", // dummy fix
      child: new ClipOval(
          child: CachedNetworkImage(
              imageUrl: this.imageUrl,
              width: 70.0,
              height: 70.0,
              fit: BoxFit.cover)),
    );

    return image;
  }
}
