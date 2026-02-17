import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../../../domain/entities/feed_entity.dart';

class VideoPlayerWidget extends StatelessWidget {
  final FeedEntity feed;
  final bool isPlaying;

  const VideoPlayerWidget({
    super.key,
    required this.feed,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    if (isPlaying) {
      return _VideoPlayerContent(feed: feed);
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            feed.thumbnail,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const Icon(
            Icons.play_circle_outline_sharp,
            size: 38,
            color: Color(0xFFFFFFFF),
          ),
        ],
      ),
    );
  }
}

class _VideoPlayerContent extends StatefulWidget {
  final FeedEntity feed;

  const _VideoPlayerContent({required this.feed});

  @override
  State<_VideoPlayerContent> createState() => _VideoPlayerContentState();
}

class _VideoPlayerContentState extends State<_VideoPlayerContent> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _videoController = VideoPlayerController.network(widget.feed.videoUrl);

    try {
      await _videoController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: true,
        showControls: true,
        allowFullScreen: true,
        aspectRatio: _videoController.value.aspectRatio,
      );

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized || _chewieController == null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(color: Color(0xFFFFFFFF)),
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: _videoController.value.aspectRatio,
      child: Chewie(controller: _chewieController!),
    );
  }
}
