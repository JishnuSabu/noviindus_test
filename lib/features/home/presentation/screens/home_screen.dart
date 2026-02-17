import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noviindus_test/core/di/injection.dart' as di;
import 'package:noviindus_test/features/home/presentation/screens/add_feed_screen.dart';
import 'package:noviindus_test/features/home/presentation/screens/category_list.dart';
import 'package:noviindus_test/features/home/presentation/screens/feed_list.dart';
import 'package:noviindus_test/features/home/presentation/provider/home_provider.dart';
import 'package:noviindus_test/features/home/presentation/screens/my_feed_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Color(0xFF171717),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello Maria",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Welcome back to Section",
                          style: TextStyle(
                            color: Color(0xFFD5D5D5),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final accessToken = prefs.getString("access_token");
                        log(accessToken.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) =>
                                  di.sl<HomeProvider>()
                                    ..fetchMyFeeds(token: accessToken ?? ""),
                              child: MyFeedScreen(),
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/300",
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Consumer<HomeProvider>(
                  builder: (context, provider, _) {
                    if (provider.isCategoryLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFFFFFFF),
                        ),
                      );
                    }

                    if (provider.error != null) {
                      return Text(
                        provider.error!,
                        style: const TextStyle(color: Colors.red),
                      );
                    }

                    return CategoryList(provider: provider);
                  },
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Consumer<HomeProvider>(
                  builder: (context, provider, _) {
                    if (provider.isFeedLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFFFFFFF),
                        ),
                      );
                    }
                    return FeedList(feeds: provider.feeds, provider: provider);
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider(
                  create: (_) => di.sl<HomeProvider>()..fetchCategories(),
                  child: AddFeedScreen(),
                ),
              ),
            );
          },
          shape: const CircleBorder(),
          backgroundColor: Color(0xFFC70000),
          child: const Icon(Icons.add, color: Color(0xFFFFFFFF), size: 34),
        ),
      ),
    );
  }
}
