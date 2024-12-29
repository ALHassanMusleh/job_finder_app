import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CommonServices {
  // show date picker
  static Future<DateTime> showMyDatePicker(context) async {
    DateTime selectedDate = DateTime.now();
    return selectedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          lastDate: DateTime.now(),
          firstDate: DateTime.now().subtract(
            const Duration(days: 365 * 30),
          ),
        ) ??
        selectedDate;
    // setState(() {});
  }

  // pick image
  static Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // setState(() {
      final File imageFile = File(image.path);
      // });
      print('pick');
      return imageFile;
    } else {
      return null;
    }
  }

  // upload image to supabase storage
  static Future<dynamic> uploadImageToSupabase({File? imageFile}) async {
    final supabaseStorage = Supabase.instance.client.storage.from('images');
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'uploads/$fileName';
    await supabaseStorage.upload(path, imageFile!);

    print('upload');
    final fileUrl = supabaseStorage.getPublicUrl(path);
    return fileUrl; // Return the file URL

    // return imageUrl;
  }

  // upload image to supabase storage
  static Future<dynamic> uploadFileToSupabase({File? file}) async {
    final supabaseStorage = Supabase.instance.client.storage.from('files');
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'uploads/$fileName';
    await supabaseStorage.upload(path, file!);

    print('upload');
    final fileUrl = supabaseStorage.getPublicUrl(path);
    return fileUrl; // Return the file URL

    // return imageUrl;
  }

  static Future<File> loadNetwork(String url) async {
    final response = await get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return storeFile(url, bytes);
  }

  static Future<File> storeFile(String url, List<int> bytes) async {
    final fileName = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
