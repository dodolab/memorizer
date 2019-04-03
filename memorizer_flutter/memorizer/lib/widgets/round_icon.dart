import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundIconWidget extends StatelessWidget {
  final String imageUrl;

  RoundIconWidget(@required this.imageUrl);

  @override
  Widget build(BuildContext context) {
    var image = new Hero(
      tag: this.imageUrl,
      child: new Container(
        width: 70.0,
        height: 70.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new CachedNetworkImageProvider(imageUrl),
          ),
        ),
      ),
    );

    var placeholder = new Container(
        width: 70.0,
        height: 70.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: new LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black54, Colors.black, Colors.blueGrey[600]],
          ),
        ),
        alignment: Alignment.center);


    return _buildImageCrossFade(placeholder, image, false);
  }

  AnimatedCrossFade _buildImageCrossFade(Container placeHolder, Hero image, bool isLoading){
    return new AnimatedCrossFade(
      firstChild: placeHolder,
      secondChild: image,
      crossFadeState: isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: new Duration(milliseconds: 1000),
    );
  }

}

