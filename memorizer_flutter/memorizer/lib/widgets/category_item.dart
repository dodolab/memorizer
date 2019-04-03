import 'package:flutter/material.dart';
import 'package:memorizer/entities/category_content.dart';
import 'package:memorizer/utils/shared_preferences.dart';
import 'package:memorizer/utils/style.dart';
import 'package:memorizer/widgets/round_icon.dart';

class CategoryItemWidget extends StatefulWidget {

  CategoryItemWidget({
    Key key,
    @required this.categoryContent,
    @required this.onPressed
  }) : super(key: key);

  final CategoryContent categoryContent;
  final VoidCallback onPressed;

  @override
  CategoryItemWidgetState createState() {
    return new CategoryItemWidgetState();
  }
}

class CategoryItemWidgetState extends State<CategoryItemWidget> {

  String langCode;

  @override
  Widget build(BuildContext context) {
    return new SharedPreferencesBuilder(
      pref: PREF_LANG_CODE,
        builder: (BuildContext context,
            AsyncSnapshot<String> snapshot)
    {
      langCode = snapshot.data;

      return new Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: colorDecor),
          child: _buildContent(),
        ),
      );
    });
  }

  Widget _buildContent() {
    return ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: RoundIconWidget(widget.categoryContent.items.first.imageUrl),
      title: Text(
        widget.categoryContent.name.getString(langCode),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),

      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                child: LinearProgressIndicator(
                    backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                    value: 10,
                    valueColor: AlwaysStoppedAnimation(Colors.green)),
              )),
          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(widget.categoryContent.name.getString("la"),
                    style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic))),
          )
        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: widget.onPressed,
    );
  }
}
