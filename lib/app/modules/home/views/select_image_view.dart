import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageView extends GetView {
  const SelectImageView(
      {super.key, required this.onChanged, required this.image});
  final ValueChanged<XFile?> onChanged;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pickImage(context),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(44),
            border: Border.all(
              color: Colors.grey.shade400,
            ),
            image: (image != '')
                ? DecorationImage(image: FileImage(File(image)))
                : null,
          ),
          width: 44.0,
          height: 44.0,
        ),
      ),
    );
  }

  pickImage(BuildContext context) async {
    // pick image
    final picker = ImagePicker();
    final xfile = await picker.pickImage(source: ImageSource.gallery);
    onChanged(xfile);
  }
}
