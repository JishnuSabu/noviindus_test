import 'package:flutter/material.dart';
import '../../../domain/entities/feed_entity.dart';
import 'video_player_widget.dart';

class FeedCard extends StatelessWidget {
  final FeedEntity feed;
  final bool isPlaying;
  final VoidCallback onPlay;

  const FeedCard({
    super.key,
    required this.feed,
    required this.isPlaying,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: feed.userImage != null
                ? NetworkImage(feed.userImage!)
                : null,
          ),
          title: Text(
            feed.userName,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            "5 days ago",
            style: const TextStyle(
              color: Color(0xFFD7D7D7),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        GestureDetector(
          onTap: onPlay,
          child: VideoPlayerWidget(feed: feed, isPlaying: isPlaying),
        ),

        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            feed.description,
            style: const TextStyle(
              color: Color(0xFFD5D5D5),
              fontSize: 12.5,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Divider(color: Color(0xFF101010), thickness: 5),
        const SizedBox(height: 5),
      ],
    );
  }
}
