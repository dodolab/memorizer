import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memorizer/blocs/bloc_provider.dart';
import 'package:memorizer/blocs/categories_bloc.dart';
import 'package:memorizer/models/category_card.dart';
import 'package:memorizer/widgets/category_card_widget.dart';

class CategoriesPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final CategoriesBloc categoryBloc =
    BlocProvider.of<CategoriesBloc>(context);
    print("Widget build");
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('List Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            // Display an infinite GridView with the list of all categories in the catalog,
            // that meet the filters
            child: StreamBuilder<List<CategoryCard>>(
                stream: categoryBloc.outCategoriesList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<CategoryCard>> snapshot) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return _buildCategoryCard(context, categoryBloc, index,
                          snapshot.data);
                    },
                    itemCount:
                    (snapshot.data == null ? 0 : snapshot.data.length) + 30,
                  );
                }),
          ),
        ],
      )
    );
  }

  Widget _buildCategoryCard(
      BuildContext context,
      CategoriesBloc categoryBloc,
      int index,
      List<CategoryCard> categoryCards) {

      // Notify the catalog that we are rendering CategoryCard[index]
      categoryBloc.inCategoryIndex.add(index);
    // Get the CategoryCard data
    final CategoryCard categoryCard =
    (categoryCards != null && categoryCards.length > index)
        ? categoryCards[index]
        : null;

    if (categoryCard == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return CategoryCardWidget(
        key: Key('cat_${categoryCard.id}'),
        categoryCard: categoryCard,
        onPressed: () {
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return null; // todo return detail page
          }));
        });
  }
}
