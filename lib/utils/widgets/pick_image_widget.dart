import 'dart:io';

import 'package:flutter/material.dart';
import 'package:job_finder_app/data/service/common_services/common_services.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget(
      {super.key, required this.imageFile, required this.onPressed});
  final File? imageFile;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xffF7F7FC),
            radius: 70,
            child: imageFile != null
                ? Image.file(imageFile!)
                : Image.asset('assets/images/Icon.png'),
          ),
          Positioned(
            bottom: 0,
            right: -10,
            child: CircleAvatar(
              backgroundColor: const Color(0xffF7F7FC),
              child: IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.camera_alt,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
