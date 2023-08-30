import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yukla/cubits/auth/auth_cubit.dart';
import 'package:yukla/cubits/tab/tab_cubit.dart';
import 'package:yukla/presentation/app_routes.dart';
import 'package:yukla/presentation/tab/articles/articles_screen.dart';
import 'package:yukla/presentation/tab/profile/profile_screen.dart';
import 'package:yukla/presentation/tab/websites/websites_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];

  @override
  void initState() {
    screens = [
      WebsitesScreen(),
      ArticlesScreen(),
      ProfileScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        child: IndexedStack(
          children: screens,
          index: context.watch<TabCubit>().state
        ),
        listener: (context, state) {
          if (state is AuthUnAuthenticatedState) {
            Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.web), label: "Website"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Article"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: context.watch<TabCubit>().state,
        onTap: context.read<TabCubit>().changeTabIndex,
      ),
    );
  }
}
