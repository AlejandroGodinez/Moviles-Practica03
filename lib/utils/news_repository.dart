import 'dart:convert';
import 'dart:io';

import 'package:google_login/models/new.dart';
import 'package:google_login/utils/secrets.dart';
import 'package:http/http.dart';

class NewsRepository {
  List<New> _noticiasList;

  static final NewsRepository _newsRepository = NewsRepository._internal();
  factory NewsRepository() {
    return _newsRepository;
  }

  NewsRepository._internal();
  Future<List<New>> getAvailableNoticias(String query) async {
    // utilizar variable q="$query" para buscar noticias en especifico
    // https://newsapi.org/v2/top-headlines?country=mx&q=futbol&category=sports&apiKey&apiKey=laAPIkey
    // crear modelos antes
    var _uri;
    // revisar lo que contiene la variable query
    if (query == "sports") {
      _uri = Uri(
        scheme: 'https',
        host: 'newsapi.org',
        path: 'v2/top-headlines',
        queryParameters: {
          "country": "mx",
          "category": "sports",
          "apiKey": apiKey
        },
      );
    } else {
      _uri = Uri(
        scheme: 'https',
        host: 'newsapi.org',
        path: 'v2/everything',
        queryParameters: {
          "q": query,
          "apiKey": apiKey
        },
      );
    }

    // TODO: completar request y deserializacion
    try {
      final response = await get(_uri);
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> data = jsonDecode(response.body)["articles"];
        _noticiasList =
            ((data).map((element) => New.fromJson(element))).toList();
        return _noticiasList;
      }
      return [];
    } catch (e) {
      //arroje un error
      throw "Ha ocurrido un error: $e";
    }
  }
}
