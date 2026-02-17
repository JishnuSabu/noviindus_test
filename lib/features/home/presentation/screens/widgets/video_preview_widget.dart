import 'package:flutter/material.dart';
import 'package:noviindus_test/features/home/presentation/provider/add_feed_provider.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewWidget extends StatelessWidget {
  final AddFeedProvider provider;

  const VideoPreviewWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    if (!provider.isVideoInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: provider.videoController!.value.size.width,
              height: provider.videoController!.value.size.height,
              child: VideoPlayer(provider.videoController!),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            provider.videoController!.value.isPlaying
                ? Icons.pause_circle
                : Icons.play_circle,
            size: 50,
            color: Colors.white,
          ),
          onPressed: () {
            provider.videoController!.value.isPlaying
                ? provider.videoController!.pause()
                : provider.videoController!.play();
          },
        ),
      ],
    );
  }
}
