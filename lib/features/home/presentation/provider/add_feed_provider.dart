import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noviindus_test/features/home/domain/use_cases/add_feed_use_case.dart';
import 'package:video_player/video_player.dart';

class AddFeedProvider extends ChangeNotifier {
  File? selectedVideo;
  File? selectedImage;
  String description = "";
  List<int> selectedCategories = [];

  final TextEditingController descController = TextEditingController();

  bool isLoading = false;
  double uploadProgress = 0.0;

  final AddFeedUseCase addFeedUseCase;

  AddFeedProvider(this.addFeedUseCase);

  final ImagePicker _picker = ImagePicker();

  VideoPlayerController? videoController;
  bool isVideoInitialized = false;

  Future<void> pickVideo() async {
    final picked = await _picker.pickVideo(source: ImageSource.gallery);
    if (picked == null) return;

    if (!picked.path.endsWith(".mp4")) {
      throw Exception("Only MP4 videos allowed");
    }

    final file = File(picked.path);

    final controller = VideoPlayerController.file(file);
    await controller.initialize();

    if (controller.value.duration.inMinutes > 5) {
      throw Exception("Video must be under 5 minutes");
    }

    await videoController?.dispose();

    selectedVideo = file;
    videoController = controller;
    isVideoInitialized = true;

    notifyListeners();
  }

  Future<void> pickThumbnail() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    selectedImage = File(picked.path);
    notifyListeners();
  }

  void toggleCategory(int id) {
    if (selectedCategories.contains(id)) {
      selectedCategories.remove(id);
    } else {
      selectedCategories.add(id);
    }
    notifyListeners();
  }

  bool validate() {
    if (selectedVideo == null) return false;
    if (selectedImage == null) return false;
    if (description.isEmpty) return false;
    if (selectedCategories.isEmpty) return false;

    return true;
  }

  Future<void> upload(String token) async {
    if (!validate()) throw Exception("All fields are mandatory");

    isLoading = true;
    notifyListeners();

    await addFeedUseCase.call(
      videoPath: selectedVideo!.path,
      imagePath: selectedImage!.path,
      desc: description,
      categoryIds: selectedCategories,
      token: token,
      onProgress: (progress) {
        uploadProgress = progress;
        notifyListeners();
      },
    );

    isLoading = false;
    notifyListeners();
  }

  void clear() async {
    selectedVideo = null;
    selectedImage = null;
    description = "";
    selectedCategories.clear();
    uploadProgress = 0.0;

    descController.clear();

    await videoController?.dispose();
    videoController = null;
    isVideoInitialized = false;

    notifyListeners();
  }

  @override
  void dispose() {
    videoController?.dispose();
    descController.dispose();
    super.dispose();
  }
}
