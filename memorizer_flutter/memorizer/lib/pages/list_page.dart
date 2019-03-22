import 'package:flutter/material.dart';
import 'package:memorizer/models/category_content.dart';
import 'package:memorizer/widgets/category_item.dart';
import 'package:memorizer/blocs/categories_bloc.dart';
import 'package:memorizer/blocs/bloc_provider.dart';

class ListPage extends StatelessWidget {
  final String title;

  ListPage({Key key, this.title}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final CategoriesBloc categoryBloc =
    BlocProvider.of<CategoriesBloc>(context);
    categoryBloc.fetchCategories();

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: StreamBuilder<List<CategoryContent>>(
        stream: categoryBloc.outCategoriesList,
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryContent>> snapshot) {
          if(snapshot.data != null){
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return new CategoryItem(snapshot.data[index]);
              },
            );
          } else{
            return null;
          }
        })
    );

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.blur_on, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.hotel, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }
}