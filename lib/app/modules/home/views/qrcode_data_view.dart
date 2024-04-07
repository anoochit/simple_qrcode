import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:simply_qrcode/app/modules/home/views/select_image_view.dart';

import '../controllers/home_controller.dart';
import 'select_color_view.dart';

class QRCodeDataView extends GetView<HomeController> {
  const QRCodeDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Barcode Data & Style',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Gap(4.0),
          TextFormField(
            controller: controller.qrcodeTextController,
            decoration: const InputDecoration(
              hintText: 'Type your QRCode data...',
              prefixIcon: Icon(Icons.text_fields),
            ),
            keyboardType: TextInputType.text,
            onFieldSubmitted: (value) => setQRCodeData(value),
            onChanged: (value) => setQRCodeData(value),
          ),
          const Gap(8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Style',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Obx(
                () => DropdownButton<String>(
                  value: controller.qrcodeStyleValue.value,
                  items: controller.qrcodeStyle
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setQrCodeStyle(
                      style: value!,
                      foreground: controller.foregroundColor.value,
                      background: controller.backgroundColor.value,
                      imagePath: controller.imagePath.value,
                    );
                  },
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Foreground color',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Obx(
                () => SelectedColorView(
                  color: controller.foregroundColor.value,
                  onChanged: (color) {
                    setQrCodeStyle(
                      style: controller.qrcodeStyleValue.value,
                      foreground: color,
                      background: controller.backgroundColor.value,
                      imagePath: controller.imagePath.value,
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Background color',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Obx(
                () => SelectedColorView(
                  color: controller.backgroundColor.value,
                  onChanged: (color) {
                    setQrCodeStyle(
                      style: controller.qrcodeStyleValue.value,
                      foreground: controller.foregroundColor.value,
                      background: color,
                      imagePath: controller.imagePath.value,
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Logo',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Obx(
                () => SelectImageView(
                  image: controller.imagePath.value,
                  onChanged: (xfile) {
                    setQrCodeStyle(
                      style: controller.qrcodeStyleValue.value,
                      foreground: controller.foregroundColor.value,
                      background: controller.backgroundColor.value,
                      imagePath: xfile?.path ?? '',
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  setQRCodeData(String value) {
    controller.qrcodeData.value = value;
  }

  setQrCodeStyle({
    required String style,
    required Color foreground,
    required Color background,
    required String imagePath,
  }) {
    controller.qrcodeStyleValue.value = style;
    controller.backgroundColor.value = background;
    controller.foregroundColor.value = foreground;
    controller.imagePath.value = imagePath;
    switch (style) {
      case 'normal':
        controller.prettyQrDecoration.value = PrettyQrDecoration(
          image: (imagePath != '')
              ? PrettyQrDecorationImage(image: FileImage(File(imagePath)))
              : null,
          background: controller.backgroundColor.value,
          shape: PrettyQrSmoothSymbol(
            roundFactor: 0.0,
            color: controller.foregroundColor.value,
          ),
        );
        break;
      case 'smooth':
        controller.prettyQrDecoration.value = PrettyQrDecoration(
          image: (imagePath != '')
              ? PrettyQrDecorationImage(image: FileImage(File(imagePath)))
              : null,
          background: controller.backgroundColor.value,
          shape: PrettyQrSmoothSymbol(
            color: controller.foregroundColor.value,
          ),
        );
        break;
      case 'dotted':
        controller.prettyQrDecoration.value = PrettyQrDecoration(
          image: (imagePath != '')
              ? PrettyQrDecorationImage(image: FileImage(File(imagePath)))
              : null,
          background: controller.backgroundColor.value,
          shape: PrettyQrRoundedSymbol(
            color: controller.foregroundColor.value,
          ),
        );
        break;
      default:
    }
  }
}
