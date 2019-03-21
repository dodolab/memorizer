import 'dart:async';
import 'dart:collection';

import 'package:memorizer/blocs/bloc_provider.dart';
import 'package:memorizer/models/category_card.dart';
import 'package:memorizer/models/categories_result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:memorizer/api/memorizer_api.dart';


class CategoriesBloc implements BlocBase {
  ///
  /// Max number of categories per fetched page
  ///
  final int _categoriesPerPage = 20;
  ///
  /// Total number of categories in the catalog
  ///
  int _totalCategories = -1;

  /// all pages fetched from the internet
  final _fetchPages = <int, CategoryPageResult>{};

  /// pages currently being fetched
  final _pagesBeingFetched = Set<int>();

  // ##########  STREAMS  ##############


  PublishSubject<List<CategoryCard>> _categoriesController = PublishSubject<List<CategoryCard>>();
  Sink<List<CategoryCard>> get _inCategoriesList => _categoriesController.sink;
  Stream<List<CategoryCard>> get outCategoriesList => _categoriesController.stream;

  ///
  /// Each time we need to render a category, we will pass its [index]
  /// so that, we will be able to check whether it has already been fetched
  /// If not, we will automatically fetch the page from the internet
  ///
  PublishSubject<int> _indexController = PublishSubject<int>();
  Sink<int> get inCategoryIndex => _indexController.sink;

  ///
  /// Constructor
  ///
  CategoriesBloc() {
    //
    // As said, each time we will have to render a MovieCard, the latter will send us
    // the [index] of the movie to render.  If the latter has not yet been fetched
    // we will need to fetch the page from the Internet.
    // Therefore, we need to listen to such request in order to handle the request.
    //
    _indexController.stream
    // take some time before jumping into the request (there might be several ones in a row)
        .bufferTime(Duration(microseconds: 500))
    // and, do not update where this is no need
        .where((batch) => batch.isNotEmpty)
        .listen(_handleIndexes);
  }

  void dispose(){
    _categoriesController.close();
    _indexController.close();
  }

  // ############# HANDLING  #####################

  ///
  /// For each of the category index, we need to check if the data
  /// has already been fetched.  As the user might scroll rapidly, this
  /// might end up with multiple pages to be fetched from Internet.
  ///
  void _handleIndexes(List<int> indexes) {
    // Iterate all the requested indexes and,
    // get the index of the page corresponding to the index
    indexes.forEach((int index){
      final int pageIndex = 1 + ((index+1) ~/ _categoriesPerPage);

      // check if the page has already been fetched
      if (!_fetchPages.containsKey(pageIndex)){
        if (!_pagesBeingFetched.contains(pageIndex)){
          _pagesBeingFetched.add(pageIndex);
          api.pagedList(pageIndex: pageIndex)
              .then((CategoryPageResult fetchedPage) => _handleFetchedPage(fetchedPage, pageIndex));
        }
      }
    });
  }


  void _handleFetchedPage(CategoryPageResult page, int pageIndex){
    // Remember the page
    _fetchPages[pageIndex] = page;
    // Remove it from the ones being fetched
    _pagesBeingFetched.remove(pageIndex);

    // Notify anyone interested in getting access to the content
    // of all pages
    List<CategoryCard> categories = <CategoryCard>[];
    List<int> pageIndexes = _fetchPages.keys.toList();
    pageIndexes.sort((a, b) => a.compareTo(b));

    final int minPageIndex = pageIndexes[0];
    final int maxPageIndex = pageIndexes[pageIndexes.length - 1];

    // there might be a gap since the user might have scrolled rapidly
    if (minPageIndex == 1){
      for (int i = 1; i <= maxPageIndex; i++){
        if (!_fetchPages.containsKey(i)){
          // As soon as there is a hole, stop
          break;
        }
        // Add the list of fetched categories to the list
        categories.addAll(_fetchPages[i].categories);
      }
    }

    // Only notify when there are categories
    if (categories.length > 0){
      _inCategoriesList.add(UnmodifiableListView<CategoryCard>(categories));
    }
  }
}
