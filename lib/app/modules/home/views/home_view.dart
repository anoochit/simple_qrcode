// ignore_for_file: non_const_call_to_literal_constructor, use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final TextEditingController qrcodeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    qrcodeTextController.text = controller.qrcodeData.value;

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return buildPortraitView(context);
        }

        return buildLandscapeView(context);
      },
    );
  }

  Widget buildLandscapeView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRCode Generator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildQRCodeView(context, true),
          const VerticalDivider(width: 1.0),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                buildQRCodeData(context),
                buildSaveButton(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildPortraitView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRCode Generator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          const Gap(8.0),
          buildQRCodeView(context, false),
          const Gap(8.0),
          const Divider(),
          buildQRCodeData(context),
          buildSaveButton(context)
        ],
      ),
    );
  }

  Widget buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FilledButton.icon(
        onPressed: () => saveQRCode(context),
        icon: const Icon(Icons.download),
        label: const Text('Save'),
      ),
    );
  }

  Widget buildQRCodeData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Barcode data & style',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Gap(8.0),
          TextFormField(
            controller: qrcodeTextController,
            decoration: const InputDecoration(
              hintText: 'Type your QRCode data...',
              prefixIcon: Icon(Icons.text_fields),
            ),
            keyboardType: TextInputType.text,
            onFieldSubmitted: (value) => setQRCodeData(value),
          ),
          const Gap(16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Smooth'),
              Obx(
                () => Switch.adaptive(
                  value: controller.qrcodeStyle.value,
                  onChanged: (value) => setQrCodeStyle(value),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Rounded cornors'),
              Obx(
                () => Switch.adaptive(
                  value: controller.qrcodeRounded.value,
                  onChanged: (value) => setQrCodeShap(value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildQRCodeView(BuildContext context, bool isLandscape) {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.width * 0.8;

    if (isLandscape == true) {
      width = MediaQuery.of(context).size.height;
      height = MediaQuery.of(context).size.height;
    }

    return Obx(
      () => Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.5,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8.0),
          child: PrettyQrView.data(
            data: controller.qrcodeData.value,
            errorCorrectLevel: QrErrorCorrectLevel.L,
            decoration: (controller.qrcodeStyle.value)
                ? PrettyQrDecoration(
                    background: Colors.white,
                  )
                : PrettyQrDecoration(
                    background: Colors.white,
                    shape: (controller.qrcodeRounded.value)
                        ? const PrettyQrRoundedSymbol()
                        : PrettyQrRoundedSymbol(
                            borderRadius: BorderRadius.zero,
                          ),
                  ),
          ),
        ),
      ),
    );
  }

  setQRCodeData(String value) {
    controller.qrcodeData.value = value;
  }

  setQrCodeShap(bool value) {
    controller.qrcodeRounded.value = value;
    if (value) {
      controller.qrcodeStyle.value = false;
    }
  }

  setQrCodeStyle(bool value) {
    controller.qrcodeStyle.value = value;
  }

  saveQRCode(BuildContext context) async {
    final qrCode = QrCode.fromData(
      data: controller.qrcodeData.value,
      errorCorrectLevel: QrErrorCorrectLevel.L,
    );

    final qrImage = QrImage(qrCode);
    final qrImageBytes = await qrImage.toImageAsBytes(
      format: ImageByteFormat.png,
      size: 512,
      decoration: (controller.qrcodeStyle.value)
          ? const PrettyQrDecoration(
              background: Colors.white,
            )
          : PrettyQrDecoration(
              background: Colors.white,
              shape: (controller.qrcodeRounded.value)
                  ? const PrettyQrRoundedSymbol()
                  : PrettyQrRoundedSymbol(),
            ),
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
