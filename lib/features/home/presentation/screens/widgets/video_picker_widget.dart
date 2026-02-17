import 'package:flutter/material.dart';
import 'package:noviindus_test/features/home/presentation/provider/add_feed_provider.dart';
import 'package:noviindus_test/features/home/presentation/screens/widgets/dotted_border_painter.dart';
import 'package:noviindus_test/features/home/presentation/screens/widgets/video_preview_widget.dart';

class VedioPickerWidget extends StatelessWidget {
  const VedioPickerWidget({super.key, required this.provider});

  final AddFeedProvider provider;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          await provider.pickVideo();
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(e.toString())));
        }
      },
      child: CustomPaint(
        painter: DottedBorderPainter(
          color: Color(0xFFFFFFFF),
          strokeWidth: .5,
          dashWidth: 12,
          gap: 8,
          radius: 10,
        ),
        child: Container(
          height: 273,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: provider.selectedVideo == null
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.video_collection_outlined,
                        color: Colors.white54,
                        size: 40,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Select a video from Gallery",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: VideoPreviewWidget(provider: provider),
                ),
        ),
      ),
    );
  }
}
