import 'package:flutter/material.dart';
import 'package:noviindus_test/features/auth/presentation/provider/auth_provider.dart';
import 'package:noviindus_test/features/auth/presentation/screens/login_screen.dart';
import 'package:noviindus_test/features/home/presentation/provider/home_provider.dart';
import 'package:noviindus_test/features/home/presentation/screens/feed_list.dart';
import 'package:provider/provider.dart';

class MyFeedScreen extends StatelessWidget {
  const MyFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171717),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 14,
            color: Color(0xFFFFFFFF),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Feed',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Consumer<AuthProvider>(
            builder: (context, provider, _) {
              return IconButton(
                icon: const Icon(
                  Icons.logout,
                  size: 20,
                  color: Color(0xFFFFFFFF),
                ),
                onPressed: () async {
                  await provider.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          if (provider.isMyFeedLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return FeedList(feeds: provider.myFeeds, provider: provider);
        },
      ),
    );
  }
}
