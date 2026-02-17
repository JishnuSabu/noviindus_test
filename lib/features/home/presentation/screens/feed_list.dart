import 'package:flutter/material.dart';
import 'package:noviindus_test/features/home/domain/entities/feed_entity.dart';
import 'package:noviindus_test/features/home/presentation/provider/home_provider.dart';
import 'package:noviindus_test/features/home/presentation/screens/widgets/feed_card.dart';

class FeedList extends StatelessWidget {
  final HomeProvider provider;
  final List<FeedEntity> feeds;

  const FeedList({super.key, required this.provider, required this.feeds});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: feeds.length,
      itemBuilder: (context, index) {
        final feed = feeds[index];
        return FeedCard(
          feed: feed,
          isPlaying: provider.currentlyPlayingId == feed.id,
          onPlay: () => provider.setPlayingVideo(feed.id),
        );
      },
    );
  }
}
