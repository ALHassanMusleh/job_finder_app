import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget(
      {super.key,
      required this.imageFile,
      required this.onPressed,
      this.isImageUploaded = false,
      this.imagePath});
  final File? imageFile;
  final void Function()? onPressed;
  final bool isImageUploaded;
  final String? imagePath;

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
                : isImageUploaded
                    ? CachedNetworkImage(
                        imageUrl: imagePath!,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        width: MediaQuery.of(context).size.width * .31,
                        height: MediaQuery.of(context).size.height * .22,
                      )
                    : Image.asset('assets/images/Icon.png'),

            // child: isImageUploaded
            //     ? CachedNetworkImage(
            //         imageUrl: imagePath!,
            //         placeholder: (context, url) => const Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //         errorWidget: (context, url, error) => Icon(Icons.error),
            //         width: MediaQuery.of(context).size.width * .31,
            //         height: MediaQuery.of(context).size.height * .22,
            //       )
            //     : imageFile != null
            //         ? Image.file(imageFile!)
            //         : Image.asset('assets/images/Icon.png'),
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
