import 'package:flutter/material.dart';
import 'package:noviindus_test/features/home/presentation/provider/add_feed_provider.dart';
import 'package:noviindus_test/features/home/presentation/screens/widgets/add_feed_category_widget.dart';
import 'package:noviindus_test/features/home/presentation/screens/widgets/thumbnail_picker_widget.dart';
import 'package:noviindus_test/features/home/presentation/screens/widgets/cm_container.dart';
import 'package:noviindus_test/features/home/presentation/screens/widgets/video_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFeedScreen extends StatelessWidget {
  const AddFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddFeedProvider>(
      builder: (context, provider, child) {
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
              'Add Feeds',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: GestureDetector(
                  onTap: () async {
                    if (!provider.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("All fields are mandatory"),
                        ),
                      );
                      return;
                    }

                    try {
                      final prefs = await SharedPreferences.getInstance();
                      final accessToken = prefs.getString("access_token");

                      if (accessToken == null) {
                        throw Exception("User not logged in");
                      }

                      await provider.upload(accessToken);

                      provider.clear();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Feed Uploaded Successfully"),
                          backgroundColor: Colors.green[500],
                        ),
                      );

                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },

                  child: provider.isLoading
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        )
                      : CmContainer(
                          text: "Share Post",
                          bgColor: const Color(0xFFC70000).withOpacity(0.2),
                        ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (provider.isLoading) ...[
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: provider.uploadProgress,
                    backgroundColor: Colors.grey.shade800,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      "${(provider.uploadProgress * 100).toStringAsFixed(0)}% uploading",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                VedioPickerWidget(provider: provider),

                const SizedBox(height: 30),
                ThumbnailPickerWidget(provider: provider),
                const SizedBox(height: 20),

                const Text(
                  "Add Description",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: provider.descController,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter description...",
                    hintStyle: const TextStyle(color: Colors.white38),
                  ),
                  onChanged: (value) {
                    provider.description = value;
                  },
                ),

                const SizedBox(height: 20),

                AddFeedCategoryWidget(provider: provider),

                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
