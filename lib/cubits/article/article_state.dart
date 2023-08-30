import 'package:equatable/equatable.dart';
import 'package:yukla/data/models/articles/add_article_model.dart';
import 'package:yukla/data/models/articles/articles_model.dart';
import 'package:yukla/data/models/status/form_status.dart';
import 'package:yukla/data/models/websites/website_model.dart';

class ArticleState extends Equatable {
  final String statusText;
  final ArticlesModel articleModel;
  ArticlesModel? articleDetail;
  final List<ArticlesModel> articles;
  final FormStatus status;
  AddArticleModel addArticleModel;

  ArticleState({
    required this.articleModel,
    this.articleDetail,
    this.statusText = "",
    this.status = FormStatus.pure,
    required this.articles,
    required this.addArticleModel,
  });

  ArticleState copyWith({
    String? statusText,
    ArticlesModel? articleModel,
    ArticlesModel? articleDetail,
    List<ArticlesModel>? articles,
    FormStatus? status,
    AddArticleModel? addArticleModel,
  }) =>
      ArticleState(
        articleDetail: articleDetail ?? this.articleDetail,
        articleModel: articleModel ?? this.articleModel,
        articles: articles ?? this.articles,
        statusText: statusText ?? this.statusText,
        status: status ?? this.status,
        addArticleModel: addArticleModel ?? this.addArticleModel,
      );

  @override
  List<Object?> get props => [
        articleModel,
        articles,
        statusText,
        status,
        articleDetail,
        addArticleModel,
      ];

  bool canAddArticle() {
    if (addArticleModel.image.isEmpty) return false;
    if (addArticleModel.hashtag.isEmpty) return false;
    if (addArticleModel.description.isEmpty) return false;
    if (addArticleModel.title.isEmpty) return false;
    return true;
  }
}
