
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memorizer/api/memorizer_api.dart';
import 'package:memorizer/blocs/categories_bloc.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:memorizer/pages/categories.dart';
import 'reducers/app_reducer.dart';
import 'models/app_state.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:memorizer/blocs/application_bloc.dart';
import 'package:memorizer/blocs/bloc_provider.dart';

Future<void> main() async {
//  debugPrintRebuildDirtyWidgets = true;
  return runApp(
      BlocProvider<ApplicationBloc>(
        bloc: ApplicationBloc(),
        child: BlocProvider<CategoriesBloc>(
          bloc: CategoriesBloc(),
          child: MainApp(),
        ),
      )
  );
}


class MainApp extends StatelessWidget {
  String title = 'Memorizer';

  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(),
    middleware: [new LoggingMiddleware.printer()],
  );

  @override
  Widget build(BuildContext context) {
    var assetsBundle = DefaultAssetBundle.of(context);
    api.bundle = assetsBundle;

    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: title,
        home: new CategoriesPage(),
      ),
    );
  }
}