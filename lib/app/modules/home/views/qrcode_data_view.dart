import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

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
            'Barcode data & style',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Gap(8.0),
          TextFormField(
            controller: controller.qrcodeTextController,
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
}
