import 'dart:async';
import 'dart:collection';

import 'package:memorizer/blocs/bloc_provider.dart';
import 'package:memorizer/models/category_content.dart';
import 'package:memorizer/models/categories_result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:memorizer/api/memorizer_api.dart';


class CategoriesBloc implements BlocBase {

  /// all pages fetched from the internet
  CategoryPageResult _fetchedPage = null;

  var _pageBeingFetched = false;

  // ##########  STREAMS  ##############


  PublishSubject<List<CategoryContent>> _categoriesController = PublishSubject<List<CategoryContent>>();
  Sink<List<CategoryContent>> get _inCategoriesList => _categoriesController.sink;
  Stream<List<CategoryContent>> get outCategoriesList => _categoriesController.stream;

  BehaviorSubject<int> _totalCategoriesController = BehaviorSubject<int>();
  Sink<int> get inTotalCategories => _totalCategoriesController.sink;
  Stream<int> get outTotalCategories => _totalCategoriesController.stream;


  void dispose(){
    _categoriesController.close();
  }

  // ############# HANDLING  #####################

  ///
  /// For each of the category index, we need to check if the data
  /// has already been fetched.  As the user might scroll rapidly, this
  /// might end up with multiple pages to be fetched from Internet.
  ///
  void fetchCategories() {

    if(_fetchedPage == null) {
      _pageBeingFetched = true;
      api.pagedList()
          .then((CategoryPageResult fetchedPage) {
          _pageBeingFetched = false;
          _handleFetchedPage(fetchedPage);
          _fetchedPage = fetchedPage;
      });
    }
  }


  void _handleFetchedPage(CategoryPageResult page) {
    print("IN TOTAL CATEGORIES SET");
    inTotalCategories.add(page.totalResults);
    // Only notify when there are categories
    if (page.categories.length > 0){
      _inCategoriesList.add(UnmodifiableListView<CategoryContent>(page.categories));
    }
  }
}
