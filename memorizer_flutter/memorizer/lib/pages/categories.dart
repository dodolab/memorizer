import 'package:flutter/material.dart';
import 'package:memorizer/lang/sit_localizations.dart';
import 'package:memorizer/models/category_content.dart';
import 'package:memorizer/pages/category_detail.dart';
import 'package:memorizer/utils/style.dart';
import 'package:memorizer/widgets/category_card_widget.dart';
import 'package:memorizer/blocs/categories_bloc.dart';
import 'package:memorizer/blocs/bloc_provider.dart';
import 'package:memorizer/widgets/category_item.dart';

class CategoriesPage extends StatefulWidget {

  CategoriesPage();

  @override
  _CategoriesPageState createState() {
    return new _CategoriesPageState();
  }
}

class _CategoriesPageState extends State<CategoriesPage> {

  CategoriesBloc categoryBloc;

  @override
  void initState() {
    super.initState();
    _createBloc();
  }

  @override
  void didUpdateWidget(CategoriesPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disposeBloc();
    _createBloc();
  }

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  void _createBloc() {
    categoryBloc =
        BlocProvider.of<CategoriesBloc>(context);
    categoryBloc.fetchCategories();
  }

  void _disposeBloc() {
    categoryBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: defaultBgr,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.image)),
              ],
            ),
            title: Text(SitLocalizations.of(context).categories),
          ),
          // wait for the bloc to load all categories
          body: StreamBuilder<List<CategoryContent>>(
              stream: categoryBloc.outCategoriesList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<CategoryContent>> snapshot) {
                if(snapshot.data == null){
                  return Center(child: CircularProgressIndicator());
                }

                return TabBarView(
                  children: [
                    Container(
                        child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new CategoryItemWidget(
                            key: Key('cat_${index}'),
                            categoryContent: snapshot.data[index],
                            onPressed: () {_navigateToDetailPage(snapshot.data[index]);});
                      },
                    )),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return _buildGalleryCard(context, categoryBloc, index, snapshot.data[index]);
                      },
                      itemCount: snapshot.data.length),
                  ],
                );
              })),
    );
  }

  Widget _buildGalleryCard(BuildContext context, CategoriesBloc categoryBloc,
      int index, CategoryContent categoryContent) {

    return CategoryCardWidget(
        key: Key('cat_${index}'),
        categoryContent: categoryContent,
        onPressed: () {
          _navigateToDetailPage(categoryContent);
        });
  }

  _navigateToDetailPage(CategoryContent categoryContent) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new CategoryDetailPage(categoryContent);
    }));
  }
}
