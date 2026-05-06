import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final box = GetStorage();
  var userName = "User".obs;
  var profileImagePath = "".obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  void refreshData() {
    userName.value = box.read('user_name') ?? "Ghazal"; //
    profileImagePath.value = box.read('profile_image_path') ?? "";
  }

  // التعديل هنا: نمرر المصدر (Source) للدالة
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        imageQuality: 80,
      );

      if (image != null) {
        final Directory appDocDir = await getApplicationDocumentsDirectory();
        String fileName =
            'profile_${DateTime.now().millisecondsSinceEpoch}.png';
        String savedPath = '${appDocDir.path}/$fileName';

        await File(image.path).copy(savedPath);

        profileImagePath.value = savedPath;
        box.write('profile_image_path', savedPath);
        update();
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }

  void deleteImage() {
    if (profileImagePath.value.isNotEmpty) {
      try {
        final file = File(profileImagePath.value);
        if (file.existsSync()) {
          file.deleteSync();
        }
      } catch (e) {
        print("Error deleting file: $e");
      }
    }
    box.remove('profile_image_path');
    profileImagePath.value = "";
    update();
  }

  void updateName(String newName) {
    userName.value = newName;
    box.write('user_name', newName);
    update();
  }
}
