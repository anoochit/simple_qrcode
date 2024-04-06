// ignore_for_file: non_const_call_to_literal_constructor, use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:simply_qrcode/app/modules/home/controllers/home_controller.dart';

class SaveButtonView extends GetView<HomeController> {
  const SaveButtonView({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FilledButton.icon(
        onPressed: () => saveQRCode(context),
        icon: const Icon(Icons.download),
        label: const Text('Save'),
      ),
    );
  }

  saveQRCode(BuildContext context) async {
    final qrCode = QrCode.fromData(
      data: controller.qrcodeData.value,
      errorCorrectLevel: QrErrorCorrectLevel.L,
    );

    final qrImage = QrImage(qrCode);
    final qrImageBytes = await qrImage.toImageAsBytes(
      format: ImageByteFormat.png,
      size: 1024,
      decoration: controller.prettyQrDecoration.value,
    );

    final buffer = qrImageBytes!.buffer;

    await ImageGallerySaver.saveImage(
      buffer.asUint8List(
        qrImageBytes.offsetInBytes,
        qrImageBytes.lengthInBytes,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Save image to gallery'),
      ),
    );
  }
}
