import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memorizer/lang/sit_localizations.dart';
import 'package:memorizer/entities/species_item.dart';
import 'package:memorizer/pages/gallery.dart';
import 'package:memorizer/pages/practice_confirm.dart';
import 'package:memorizer/pages/species_detail.dart';
import 'package:memorizer/utils/style.dart';
import 'package:memorizer/widgets/species_item.dart';

class SummaryPage extends StatefulWidget {
  final List<SpeciesItem> failedItems;
  final List<SpeciesItem> failedAnswers;
  final int totalItems;

  SummaryPage(this.totalItems, this.failedItems, this.failedAnswers);

  @override
  _SummaryPageState createState() => new _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildSummary() {
    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 32.0),
      decoration: new BoxDecoration(
        gradient: detailGradient,
      ),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(
            "${widget.totalItems - widget.failedItems.length}/${widget.totalItems}",
            style: new TextStyle(fontSize: 82.0),
          ),
        ],
      ),
    );
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
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[_buildSummary()],
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Container(
            margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0),
            child:
                Text(SitLocalizations.of(context).error_entities, style: TextStyle(fontSize: 16))),
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
