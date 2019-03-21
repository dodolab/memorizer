import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memorizer/models/categories_result.dart';

class MemorizerApi {
  final _httpClient = new HttpClient();
  AssetBundle bundle;


  Future<CategoryPageResult> pagedList({int pageIndex: 1}) async {

    var data = await bundle.loadString("assets/data.json");

    CategoryPageResult list = CategoryPageResult.fromJSON(json.decode(data));

    // Give some additional delay to simulate slow network
    await Future.delayed(const Duration(seconds: 1));
    return list;
  }
}

MemorizerApi api = MemorizerApi();