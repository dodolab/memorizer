import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:memorizer/blocs/bloc_provider.dart';
import 'package:memorizer/blocs/categories_bloc.dart';
import 'package:memorizer/models/category_content.dart';
import 'package:memorizer/widgets/category_card_widget.dart';
import 'package:memorizer/pages/practice.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final CategoriesBloc categoryBloc =
    BlocProvider.of<CategoriesBloc>(context);
    categoryBloc.fetchCategories();

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
            child: StreamBuilder<int>(
          stream: categoryBloc.outTotalCategories,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot1){
            return StreamBuilder<List<CategoryContent>>(
              stream: categoryBloc.outCategoriesList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<CategoryContent>> snapshot2) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return _buildCategoryCard(context, categoryBloc, index,
                        snapshot2.data, snapshot1.data ?? 20);
                  },
                  itemCount:
                  (snapshot1.data == null ? 30 : snapshot1.data),
                );
              });
        }
      )
          ),
        ],
      )
    );
  }

  Widget _buildCategoryCard(
      BuildContext context,
      CategoriesBloc categoryBloc,
      int index,
      List<CategoryContent> categoryCards,
      int totalItems) {

    if(index >= totalItems) {
      return null;
    }

    // Get the CategoryCard data
    final CategoryContent categoryCard =
    (categoryCards != null && categoryCards.length > index)
        ? categoryCards[index]
        : null;

    if (categoryCard == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return CategoryCardWidget(
        key: Key('cat_${categoryCard.name.getString("cs")}'),
        categoryCard: categoryCard,
        onPressed: () {
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return Practice(title: "Dojo", items: categoryCard.items); // todo return detail page
          }));
        });
  }
}
