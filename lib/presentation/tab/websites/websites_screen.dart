import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yukla/cubits/website/website_cubit.dart';
import 'package:yukla/data/models/status/form_status.dart';
import 'package:yukla/data/models/websites/website_model.dart';
import 'package:yukla/presentation/app_routes.dart';
import 'package:yukla/utils/constants/constants.dart';
import 'package:yukla/utils/images/app_images.dart';
import 'package:yukla/utils/ui_utils/error_message_dialog.dart';

class WebsitesScreen extends StatefulWidget {
  const WebsitesScreen({super.key});

  @override
  State<WebsitesScreen> createState() => _WebsitesScreenState();
}

class _WebsitesScreenState extends State<WebsitesScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    Future.microtask(
        () => BlocProvider.of<WebsiteCubit>(context).getWebsites(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Websites",style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.addWebsite);
            },
            icon: const Icon(Icons.add,color: Colors.black,),
          )
        ],
      ),
      body: BlocConsumer<WebsiteCubit, WebsiteState>(
        builder: (context, state) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ...List.generate(state.websites.length, (index) {
                WebsiteModel website = state.websites[index];
                return ListTile(
                  leading: SizedBox(
                    height: 50.h,
                    width: 70.w,
                    child: CachedNetworkImage(
                      imageUrl: "$baseUrlImage${website.image}",fit: BoxFit.cover ,
                      placeholder: (context, url) => Center(child: Lottie.asset(AppImages.imageLoading),),
                      errorWidget: (context, url, error) => Center(child: Lottie.asset(AppImages.imageError),)
                    ),
                  ),
                  title: Text(
                    website.name,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle:

                  GestureDetector(
                      onTap: ()async{
                        final Uri url = Uri.parse(website.link);
                        if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                        }
                      },
                      child: Text(website.link,style: const TextStyle(color: Colors.blue),)),
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
            BlocProvider.of<WebsiteCubit>(context).getWebsites(context);
          }
        },
      ),
    );
  }
}