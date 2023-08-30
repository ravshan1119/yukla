import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:yukla/cubits/article/article_cubit.dart';
import 'package:yukla/cubits/article/article_state.dart';
import 'package:yukla/data/models/articles/articles_model.dart';
import 'package:yukla/presentation/tab/articles/sub_screens/button.dart';
import 'package:yukla/utils/colors/app_colors.dart';
import 'package:yukla/utils/images/app_images.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({super.key, required this.articlesModel});

  final ArticlesModel articlesModel;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: BlocConsumer<ArticleCubit,ArticleState>(
        builder: (context,state){

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(AppImages.cancel)),
                    ),

                  ],
                ),
                SizedBox(height: 33.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [
                          SizedBox(
                            height: 36.h,
                            width: 36.h,
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                    imageUrl: widget.articlesModel.avatar,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: Lottie.asset(AppImages.imageLoading),
                                    ),
                                    errorWidget: (context, url, error) => Center(
                                      child: Lottie.asset(AppImages.imageError),
                                    )),),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.articlesModel.username,style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "PlusJakartaSans",
                                  color: Colors.black
                              ),),
                              Text(widget.articlesModel.profession,style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "PlusJakartaSans",
                                  color: Colors.black
                              ),),
                            ],
                          )
                        ],
                      ),
                      GlobalButtonForArticle(title: "Follow", onTap: (){}, color: Colors.white, borderColor: Colors.black, textColor: Colors.black)

                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  height: 180.h,
                  width: double.infinity,
                  child: CachedNetworkImage(
                      imageUrl: widget.articlesModel.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: Lottie.asset(AppImages.imageLoading),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Lottie.asset(AppImages.imageError),
                      )),
                ),
                SizedBox(height: 20.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          widget.articlesModel.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                            color: Colors.black,
                          ),
                        ),
                        width: MediaQuery.of(context).size.width-50
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 11.h),


                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Text(
                        widget.articlesModel.addDate,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: AppColors.c_999999,
                        ),
                      ),
                      Text(
                        " . ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: AppColors.c_999999,
                        ),
                      ),
                      Text(
                        "${widget.articlesModel.likes} likes",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: AppColors.c_999999,
                        ),
                      ),
                      SizedBox(width: 14.w),

                      SvgPicture.asset(AppImages.saved)

                    ],
                  ),
                ),

                SizedBox(height: 11.h),


                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    widget.articlesModel.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context,state){

        },
      ),
    );
  }
}
