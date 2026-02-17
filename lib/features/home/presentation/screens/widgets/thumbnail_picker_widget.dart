import 'package:flutter/material.dart';
import 'package:noviindus_test/features/home/presentation/provider/add_feed_provider.dart';
import 'package:noviindus_test/features/home/presentation/screens/widgets/dotted_border_painter.dart';

class ThumbnailPickerWidget extends StatelessWidget {
  const ThumbnailPickerWidget({super.key, required this.provider});
  final AddFeedProvider provider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          await provider.pickThumbnail();
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
          height: 128,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: provider.selectedImage == null
              ? const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_outlined, color: Color(0xFFFFFFFF)),
                      SizedBox(width: 8),
                      Text(
                        "Add a Thumbnail",
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
                  child: Image.file(provider.selectedImage!, fit: BoxFit.fill),
                ),
        ),
      ),
    );
  }
}
