import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yukla/cubits/article/article_state.dart';
import 'package:yukla/data/models/articles/add_article_model.dart';
import 'package:yukla/data/models/articles/articles_field_keys.dart';
import 'package:yukla/data/models/articles/articles_model.dart';
import 'package:yukla/data/models/status/form_status.dart';
import 'package:yukla/data/models/universal_data.dart';
import 'package:yukla/data/repositories/articles_repository.dart';
import 'package:yukla/utils/ui_utils/loading_dialog.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit({required this.articleRepository})
      : super(
          ArticleState(
              articleModel: ArticlesModel(
                artId: 0,
                image: "",
                title: "",
                description: "",
                likes: "",
                views: "",
                addDate: "",
                username: "",
                avatar: "",
                profession: "",
                userId: 0,
              ),
              articles: const [],
              addArticleModel: AddArticleModel(
                image: "",
                title: "",
                description: "",
                hashtag: "",
              )),
        );

  final ArticleRepository articleRepository;

  getArticles(BuildContext context) async {
    emit(state.copyWith(
      status: FormStatus.loading,
      statusText: "",
    ));
    showLoading(context: context);
    UniversalData response = await articleRepository.getArticles();
    if (context.mounted) hideLoading(context: context);
    if (response.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          statusText: "get_website",
          articles: response.data as List<ArticlesModel>,
        ),
      );
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
        statusText: response.error,
      ));
    }
  }

  createArticle() async {
    emit(state.copyWith(
      status: FormStatus.loading,
      statusText: "",
    ));
    UniversalData response =
        await articleRepository.createArticle(addArticleModel: state.addArticleModel);
    if (response.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          statusText: "website_added",
        ),
      );
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
        statusText: response.error,
      ));
    }
  }



  getArticleById(int articleId) async {
    emit(state.copyWith(
      status: FormStatus.loading,
      statusText: "",
    ));
    UniversalData response = await articleRepository.getArticleById(articleId);
    if (response.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          statusText: "get_website_by_id",
          articleDetail: response.data as ArticlesModel,
        ),
      );
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
        statusText: response.error,
      ));
    }
  }

  updateArticleField({
    required ArticlesFieldKeys fieldKey,
    required dynamic value,
  }) {
    AddArticleModel currentArticleModel = state.addArticleModel;

    switch (fieldKey) {
      case ArticlesFieldKeys.title:
        {
          currentArticleModel =
              currentArticleModel.copyWith(title: value as String);
          break;
        }
      case ArticlesFieldKeys.description:
        {
          currentArticleModel =
              currentArticleModel.copyWith(description: value as String);
          break;
        }
      case ArticlesFieldKeys.hashtag:
        {
          currentArticleModel =
              currentArticleModel.copyWith(hashtag: value as String);
          break;
        }
      case ArticlesFieldKeys.image:
        {
          currentArticleModel =
              currentArticleModel.copyWith(image: value as String);
          break;
        }
    }

    debugPrint("Article: ${currentArticleModel.toJson().toString()}");

    emit(state.copyWith(addArticleModel: currentArticleModel));
  }
}
