import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../models/NewsResponse.dart';
import '../../models/SourcesResponse.dart';

class ApiManager {
  static const String apiKey = "418c4a12f757407eba96b653e5a94d7b";
  static const String baseUrl = "newsapi.org";

  // Private constructor to prevent external instantiation
  ApiManager._();

  // Private instance variable for the singleton
  static ApiManager? _instance;

  // Public method to get the singleton instance
  static ApiManager getInstance() {
    _instance ??= ApiManager._();
    return _instance!;
  }

  Future<SourcesResponse> getSources(String categoryId) async {
    Uri url = Uri.https("newsapi.org", "/v2/top-headlines/sources",
        {"apikey": apiKey, "category": categoryId});
    Response response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(jsonData);
    return sourcesResponse;
  }

  Future<NewsResponse> getNews(String sourcedId, String keyword) async {
    Uri url = Uri.https(baseUrl, "/v2/everything",
        {"apikey": apiKey, "sources": sourcedId, "q": keyword});
    Response response = await http.get(url);
    var json = jsonDecode(response.body);
    var newsResponse = NewsResponse.fromJson(json);
    return newsResponse;
  }
}
