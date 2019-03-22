import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memorizer/models/species_item.dart';
import 'package:memorizer/pages/gallery.dart';
import 'package:memorizer/pages/practice_confirm.dart';
import 'package:memorizer/pages/species_detail.dart';
import 'package:memorizer/widgets/species_item.dart';

class SummaryPage extends StatefulWidget {
  final List<SpeciesItem> failedItems;
  final List<SpeciesItem> failedAnswers;
  final int errors;
  final int totalItems;

  SummaryPage(
      this.totalItems, this.errors, this.failedItems, this.failedAnswers);

  @override
  _SummaryPageState createState() => new _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {

  @override
  void initState() {
    super.initState();
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
          new Text(
            "${widget.totalItems-widget.errors}/${widget.totalItems}",
            style: new TextStyle(fontSize: 32.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.redAccent,
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
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[dogProfile],
        ),
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
          itemCount: widget.failedItems.length,
          itemBuilder: (BuildContext context, int index) {
            return new SpeciesItemWidget(
                item: widget.failedItems[index],
                onPressed: () => navigateToDetail(widget.failedItems[index]));
          },
        )
      ]),
    );
  }

  void navigateToDetail(SpeciesItem item) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return SpeciesDetail(item: item); // todo ret
    }));
  }
}
