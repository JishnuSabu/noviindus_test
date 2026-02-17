import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:noviindus_test/features/home/domain/entities/category_entity.dart';
import 'package:noviindus_test/features/home/domain/entities/feed_entity.dart';
import 'package:noviindus_test/features/home/domain/use_cases/get_category_use_case.dart';
import 'package:noviindus_test/features/home/domain/use_cases/get_feed_use_case.dart';
import 'package:noviindus_test/features/home/domain/use_cases/get_my_feed_use_case.dart';

class HomeProvider extends ChangeNotifier {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetFeedsUseCase getFeedsUseCase;
  final GetMyFeedsUseCase getMyFeedsUseCase;

  HomeProvider(
    this.getCategoriesUseCase,
    this.getFeedsUseCase,
    this.getMyFeedsUseCase,
  );

  List<CategoryEntity> categories = [];
  bool isCategoryLoading = false;
  String? error;

  List<FeedEntity> feeds = [];
  bool isFeedLoading = false;
  String? feedError;

  int? _currentlyPlayingId;

  int? get currentlyPlayingId => _currentlyPlayingId;

  List<FeedEntity> myFeeds = [];
  bool isMyFeedLoading = false;
  String? myFeedError;

  void setPlayingVideo(int id) {
    if (_currentlyPlayingId == id) {
      _currentlyPlayingId = null;
    } else {
      _currentlyPlayingId = id;
    }

    notifyListeners();
  }

  Future<void> fetchCategories() async {
    try {
      isCategoryLoading = true;
      notifyListeners();

      categories = await getCategoriesUseCase();
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isCategoryLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFeeds() async {
    try {
      isFeedLoading = true;
      notifyListeners();

      feeds = await getFeedsUseCase();
      feedError = null;
    } catch (e) {
      feedError = e.toString();
    } finally {
      isFeedLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMyFeeds({required String token}) async {
    log("Hi");
    try {
      isMyFeedLoading = true;
      notifyListeners();

      myFeeds = await getMyFeedsUseCase(token: token);
      myFeedError = null;
    } catch (e) {
      myFeedError = e.toString();
    } finally {
      isMyFeedLoading = false;
      notifyListeners();
    }
  }
}
