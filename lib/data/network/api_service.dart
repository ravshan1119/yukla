import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:yukla/data/local/storage_repository.dart';
import 'package:yukla/data/models/articles/add_article_model.dart';
import 'package:yukla/data/models/articles/articles_model.dart';
import 'package:yukla/data/models/universal_data.dart';
import 'package:yukla/data/models/user/user_model.dart';
import 'package:yukla/data/models/websites/website_model.dart';
import 'package:yukla/utils/constants/constants.dart';

class ApiService {
  // DIO SETTINGS

  final _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Content-Type": "application/json",
      },
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeout),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeout),
    ),
  );

  ApiService() {
    _init();
  }

  _init() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          //error.response.statusCode
          debugPrint("ERRORGA KIRDI:${error.message} and ${error.response}");
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          debugPrint("SO'ROV  YUBORILDI :${requestOptions.path}");
          requestOptions.headers
              .addAll({"token": StorageRepository.getString("token")});
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint("JAVOB  KELDI :${response.requestOptions.path}");
          return handler.next(response);
        },
      ),
    );
  }

  //----------------------- AUTHENTICATION -------------------------

  Future<UniversalData> sendCodeToGmail({
    required String gmail,
    required String password,
  }) async {
    Response response;
    try {
      response = await _dio.post(
        '/gmail',
        data: {
          "gmail": gmail,
          "password": password,
        },
      );

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["message"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> confirmCode({required String code}) async {
    Response response;
    try {
      response = await _dio.post(
        '/password',
        data: {"checkPass": code},
      );

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["message"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> registerUser({required UserModel userModel}) async {
    Response response;
    _dio.options.headers = {
      "Accept": "multipart/form-data",
    };
    try {
      response = await _dio.post(
        '/register',
        data: await userModel.getFormData(),
      );
      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["data"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> loginUser({
    required String gmail,
    required String password,
  }) async {
    Response response;
    try {
      response = await _dio.post(
        '/login',
        data: {
          "gmail": gmail,
          "password": password,
        },
      );

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["data"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

// - --------------- PROFILE -----------------

  Future<UniversalData> getProfileData() async {
    Response response;
    try {
      response = await _dio.get('/users');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: UserModel.fromJson(response.data["data"]));
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  // -------------- WEBSITES ------------------------

  Future<UniversalData> createWebsite(
      {required WebsiteModel websiteModel}) async {
    Response response;
    _dio.options.headers = {
      "Accept": "multipart/form-data",
    };
    try {
      response = await _dio.post(
        '/sites',
        data: await websiteModel.getFormData(),
      );
      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["data"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> getWebsites() async {
    Response response;
    try {
      response = await _dio.get('/sites');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(
          data: (response.data["data"] as List?)
                  ?.map((e) => WebsiteModel.fromJson(e))
                  .toList() ??
              [],
        );
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> getWebsiteById(int id) async {
    Response response;
    try {
      response = await _dio.get('/sites/$id');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(
            data: WebsiteModel.fromJson(response.data["data"]));
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }



//  ____________________ ARTICLES ___________________________

  Future<UniversalData> getArticles() async {
    Response response;
    try {
      response = await _dio.get('/articles');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(
          data: (response.data["data"] as List?)
              ?.map((e) => ArticlesModel.fromJson(e))
              .toList() ??
              [],
        );
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> getArticleById(int id) async {
    Response response;
    try {
      response = await _dio.get('/articles/$id');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(
            data: ArticlesModel.fromJson(response.data["data"]));
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }


  Future<UniversalData> createArticle(
      {required AddArticleModel addArticleModel}) async {
    Response response;
    // _dio.options.headers = {
    //   "Accept": "multipart/form-data",
    // };
    try {
      response = await _dio.post(
        '/articles',
        data: addArticleModel.toJson()
      );
      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["data"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }



//  --------------  SEND MESSAGE  ---------------------


  Future<UniversalData> sendMessage() async {

    Response response;
    try {
      response = await _dio.post(
        'https://fcm.googleapis.com/fcm/send',
        data: {
          "to": "/topics/news",
          "notification": {
            "title": "YUKLA",
            "body": "YANGILIKLAR QO'SHILDI"
          },
          "data": {
            "newsTitle":
            "«Tezkor qarshi hujum umidlari o‘ta optimistik bo‘lib chiqdi»",
            "newsBody":
            "Ukraina milliy xavfsizlik va mudofaa kengashi kotibi Oleksiy Danilov 2 avgust kuni qarshi hujum asnosida Ukraina harbiylarida dedlayn yoki grafik yo‘qligini ta’kidlagan. Uning so‘zlariga ko‘ra, Rossiya egallab olgan hududlarni ozod qilish yoppa minalashtirish tufayli qiyinlashmoqda, voqealar rivoji sekin ekanidan norozilar «urush nima ekanini tushunishmaydi».Danilovning so‘zlari G‘arbda Ukraina qurolli kuchlarining frontdagi harakatlaridan norozilik kuchayib borayotgan bir paytda yangradi. Uzoq kutilgan qarshi hujum kutilmalarni oqlayotgani yo‘q, biroq G‘arb OAVda qayd etilishicha, bunga bir qator obektiv sabablar bor. Bu sabablarni harbiy ekspertlar tobora faol muhokama qilishmoqda, o‘z sirtqi muloqotlarida ular ukrainaliklarning qarshi hujum operatsiyalarini tanqid ostiga ham olishmoqda, ba’zida esa frontdagi murakkabliklar e’tiboridan, oqlab ham qo‘yishmoqda.Quyida G‘arb matbuoti sharhida tahlilchilar Ukraina qurolli kuchlarining qanday muammolarga duchor bo‘layotgani haqida so‘z yuritayotgani, frontning old chizig‘idagi so‘nggi voqealar nega Ikkinchi jahon urushida ittifoqchilarning Normandiyaga tushirilishiga mengzalayotgani haqida hikoya qilamiz.",
            "newsDataImg":
            "https://storage.kun.uz/source/9/3niYZQI_Ble_Yx9xgMOFNS3m_wzpwIGy.jpg",
            "screen_name": "news"
          },
        },
      );

      if (response.statusCode == 200) {
        return UniversalData(data: response.data["message_id"]);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
