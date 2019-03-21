import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainModel {
  final SharedPreferences _sharedPrefs;
  Set<String> _categories = Set();
  final String CATEGORIES_KEY = "CATEGORIES";

  MainModel(this._sharedPrefs) {
    _categories.addAll(_sharedPrefs
        .getStringList(CATEGORIES_KEY) ?? Set());
  }
}
