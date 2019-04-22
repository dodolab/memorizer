import 'package:flutter/material.dart';
import 'package:memorizer/lang/sit_localizations.dart';
import 'package:memorizer/entities/category_content.dart';
import 'package:memorizer/pages/category_detail.dart';
import 'package:memorizer/utils/shared_preferences.dart';
import 'package:memorizer/utils/style.dart';
import 'package:memorizer/widgets/category_card.dart';
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
  String langCode;

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
    categoryBloc = BlocProvider.of<CategoriesBloc>(context);
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
            actions: <Widget>[_buildFlagAction()],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.image)),
              ],
            ),
            title: Text(SitLocalizations.of(context).memorizer),
          ),
          // wait for the bloc to load all categories
          body: StreamBuilder<List<CategoryContent>>(
              stream: categoryBloc.outCategoriesList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<CategoryContent>> snapshot) {
                if (snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                }

                return _buildContent(snapshot.data);
              })),
    );
  }

  Widget _buildContent(List<CategoryContent> content) {
    return TabBarView(
      children: [
        Container(
            child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: content.length,
          itemBuilder: (BuildContext context, int index) {
            return new CategoryItemWidget(
                key: Key('cat_${index}'),
                categoryContent: content[index],
                onPressed: () {
                  _navigateToDetailPage(content[index]);
                });
          },
        )),
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return _buildGalleryCard(
                  context, categoryBloc, index, content[index]);
            },
            itemCount: content.length),
      ],
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

  Widget _buildFlagAction() {
    return new SharedPreferencesBuilder(
        pref: PREF_LANG_CODE,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          langCode = snapshot.data;
          return IconButton(
              icon: Image.asset("assets/${_getFlagIcon(snapshot.data)}"),
              onPressed: () {
                _showLangChangeDialog();
              });
        });
  }

  _navigateToDetailPage(CategoryContent categoryContent) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new CategoryDetailPage(categoryContent);
    }));
  }

  _showLangChangeDialog() {
    SimpleDialog dialog = SimpleDialog(
      title: Text(SitLocalizations.of(context).select_language),
      children: <Widget>[
        SimpleDialogOption(
          child: Text(SitLocalizations.of(context).lang_en),
          onPressed: () { _changeLanguage("en"); Navigator.pop(context);},
        ),
        SimpleDialogOption(
          child: Text(SitLocalizations.of(context).lang_la),
          onPressed: () {_changeLanguage("la"); Navigator.pop(context);},
        ),
        SimpleDialogOption(
          child: Text(SitLocalizations.of(context).lang_cs),
          onPressed: () {_changeLanguage("cs"); Navigator.pop(context);},
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  void _changeLanguage(String langCode) async {
    await SharedPreferencesHelper.setLanguageCode(langCode);
    setState(() {
      this.langCode = langCode;
    });
  }

  String _getFlagIcon(String langCode) {
    switch (langCode) {
      case "cs":
        return "flag_cs.png";
      case "en":
        return "flag_en.png";
      case "la":
        return "flag_la.png";
    }

    return "flag_la.png";
  }
}
