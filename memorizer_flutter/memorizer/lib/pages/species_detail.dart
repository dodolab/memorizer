import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:memorizer/entities/species_item.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SpeciesDetail extends StatelessWidget {
  SpeciesDetail({Key key, this.item}) : super(key: key);

  SpeciesItem item;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.black,
        body:
        OrientationBuilder(
          builder: (context, orientation) {
            return
              Stack(
                children: <Widget>[
                  Swiper(itemBuilder: (BuildContext context, int index){
                    return new CachedNetworkImage(imageUrl: item.imageUrls[index], fit: BoxFit.cover);
                  },
                      itemCount: item.imageUrls.length,
                      pagination: new SwiperPagination(),
                      control: new SwiperControl(),
                      itemWidth: orientation == Orientation.landscape ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height,
                      itemHeight: orientation == Orientation.landscape ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width,
                      layout: SwiperLayout.STACK,
                  ),
                ],
              );
          },
        )
    );
  }
}