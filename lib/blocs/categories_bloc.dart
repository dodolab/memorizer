import 'dart:async';
import 'dart:collection';

import 'package:memorizer/blocs/bloc_provider.dart';
import 'package:memorizer/entities/category_content.dart';
import 'package:memorizer/entities/categories_result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:memorizer/api/memorizer_api.dart';


class CategoriesBloc implements BlocBase {

  CategoryPageResult _fetchResult = null;

  var _fetchPending = false;

  PublishSubject<List<CategoryContent>> _categoriesController = PublishSubject<List<CategoryContent>>();
  Sink<List<CategoryContent>> get _inCategoriesList => _categoriesController.sink;
  Stream<List<CategoryContent>> get outCategoriesList => _categoriesController.stream;

  void dispose(){
    _categoriesController.close();
  }

  void fetchCategories() {

    if(_fetchResult == null) {
      _fetchPending = true;
      api.pagedList()
          .then((CategoryPageResult fetchedPage) {
        _fetchPending = false;
          _handleFetchedPage(fetchedPage);
        _fetchResult = fetchedPage;
      });
    }
  }


  void _handleFetchedPage(CategoryPageResult page) {
    if (page.categories.length > 0){
      _inCategoriesList.add(UnmodifiableListView<CategoryContent>(page.categories));
    }
  }
}
