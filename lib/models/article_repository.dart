import 'package:newapi_bloc/constants/app_string.dart';

import 'new_api_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class ArticleRepository {
  Future<List<Articles>> getArticles();
}

class ArticleRepositoryImplement implements ArticleRepository {
  @override
  Future<List<Articles>> getArticles() async {
    var response = await http.get(AppString.apiUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Articles> listOfArticles = NewsApiModel.fromJson(data).articles;
      return listOfArticles;
    } else {
      throw Exception();
    }
  }
}
