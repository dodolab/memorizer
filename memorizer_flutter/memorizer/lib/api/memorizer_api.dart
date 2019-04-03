import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:memorizer/models/categories_result.dart';

class MemorizerApi {
  final _httpClient = new HttpClient();
  AssetBundle bundle;

  Future<CategoryPageResult> pagedList() async {
    var data = await bundle.loadString("assets/data.json");
    CategoryPageResult list = CategoryPageResult.fromJSON(json.decode(data));

    // TODO playground:: Give some additional delay to simulate slow network
    await Future.delayed(const Duration(seconds: 1));
    return list;
  }
}

MemorizerApi api = MemorizerApi();