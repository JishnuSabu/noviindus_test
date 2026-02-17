import 'package:flutter/material.dart';
import 'package:noviindus_test/core/di/injection.dart' as di;
import 'package:noviindus_test/features/auth/presentation/provider/auth_provider.dart';
import 'package:noviindus_test/features/auth/presentation/screens/login_screen.dart';
import 'package:noviindus_test/features/home/presentation/screens/home_screen.dart';
import 'package:noviindus_test/features/home/presentation/provider/add_feed_provider.dart';
import 'package:noviindus_test/features/home/presentation/provider/home_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<AuthProvider>()..loadToken(),
        ),

        ChangeNotifierProvider<HomeProvider>(
          create: (_) => di.sl<HomeProvider>()
            ..fetchCategories()
            ..fetchFeeds(),
        ),
        ChangeNotifierProvider<AddFeedProvider>(
          create: (_) => di.sl<AddFeedProvider>(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return MaterialApp(
            theme: ThemeData(fontFamily: 'Montserrat'),
            debugShowCheckedModeBanner: false,
            home: authProvider.isLoggedIn ? const HomeScreen() : LoginScreen(),
          );
        },
      ),
    );
  }
}
