import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memorizer/api/memorizer_api.dart';
import 'package:memorizer/blocs/categories_bloc.dart';
import 'package:memorizer/pages/categories.dart';
import 'package:memorizer/blocs/bloc_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'lang/sit_localizations.dart';
import 'lang/sit_localizations_delegate.dart';

Future<void> main() async {
//  debugPrintRebuildDirtyWidgets = true;
  return runApp(BlocProvider<CategoriesBloc>(
    bloc: CategoriesBloc(),
    child: MainApp()
  ));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsBundle = DefaultAssetBundle.of(context);
    api.bundle = assetsBundle;
    return new MaterialApp(
        localizationsDelegates: [
          const SitLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
        ],
        theme: new ThemeData(brightness: Brightness.dark),
        onGenerateTitle: (context) => SitLocalizations.of(context).app_name,
        home: new CategoriesPage());
  }
}
