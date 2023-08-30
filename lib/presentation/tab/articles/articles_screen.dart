import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:yukla/cubits/article/article_cubit.dart';
import 'package:yukla/cubits/article/article_state.dart';
import 'package:yukla/data/models/articles/articles_model.dart';
import 'package:yukla/data/models/status/form_status.dart';
import 'package:yukla/presentation/tab/articles/sub_screens/add_article_screen.dart';
import 'package:yukla/presentation/tab/articles/sub_screens/article_detail_screen.dart';
import 'package:yukla/utils/colors/app_colors.dart';
import 'package:yukla/utils/constants/constants.dart';
import 'package:yukla/utils/images/app_images.dart';
import 'package:yukla/utils/ui_utils/error_message_dialog.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    Future.microtask(
        () => BlocProvider.of<ArticleCubit>(context).getArticles(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Articles",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddArticleScreen()));
              // Navigator.pushNamed(context, RouteNames.addWebsite);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: BlocConsumer<ArticleCubit, ArticleState>(
        builder: (context, state) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ...List.generate(state.articles.length, (index) {
                ArticlesModel article = state.articles[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ArticleDetailScreen(articlesModel: article)));
                    },

                    child: Container(
                      decoration: const BoxDecoration(
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24.h,
                                    width: 24.h,
                                    child: CachedNetworkImage(
                                        imageUrl: "$baseUrlImage${article.image}",
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: Lottie.asset(AppImages.imageLoading),
                                        ),
                                        errorWidget: (context, url, error) => Center(
                                          child: Lottie.asset(AppImages.imageError),
                                        )),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    article.username,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Center(child: SvgPicture.asset(AppImages.more)),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      article.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),

                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(height: 35.h,width: 150.w,child: Text(
                                    article.description,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: AppColors.c_4D4D4D,
                                    ),
                                  ),)
                                ],
                              ),
                              SizedBox(width: 16.w),
                              SizedBox(
                                height: 100.h,
                                width: 150.w,
                                child: CachedNetworkImage(
                                    imageUrl: "$baseUrlImage${article.image}",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: Lottie.asset(AppImages.imageLoading),
                                    ),
                                    errorWidget: (context, url, error) => Center(
                                      child: Lottie.asset(AppImages.imageError),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Divider(color: AppColors.c_999999,)
                        ],
                      ),
                    ),
                  ),
                );
              })
            ],
          );
        },
        listener: (context, state) {
          if (state.status == FormStatus.failure) {
            showErrorMessage(
              message: state.statusText,
              context: context,
            );
          }
          if (state.statusText == "website_added") {
            BlocProvider.of<ArticleCubit>(context).getArticles(context);
          }
        },
      ),
    );
  }
}
