import 'package:yukla/data/models/articles/add_article_model.dart';

import '../models/universal_data.dart';
import '../network/api_service.dart';

class ArticleRepository {
  final ApiService apiService;

  ArticleRepository({required this.apiService});

  Future<UniversalData> getArticles() async => apiService.getArticles();

  Future<UniversalData> createArticle(
          {required AddArticleModel addArticleModel}) async =>
      apiService.createArticle(addArticleModel: addArticleModel);

  Future<UniversalData> getArticleById(int id) async =>
      apiService.getArticleById(id);
}
