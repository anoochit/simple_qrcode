import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final TextEditingController qrcodeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    qrcodeTextController.text = controller.qrcodeData.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QRCode Generator'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrettyQrView.data(
                data: controller.qrcodeData.value,
                errorCorrectLevel: QrErrorCorrectLevel.L,
                decoration: (controller.qrcodeStyle.value)
                    ? const PrettyQrDecoration()
                    : PrettyQrDecoration(
                        shape: (controller.qrcodeRounded.value)
                            ? const PrettyQrRoundedSymbol()
                            : const PrettyQrRoundedSymbol(
                                borderRadius: BorderRadius.zero,
                              ),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.vertical,
              children: [
                TextFormField(
                  controller: qrcodeTextController,
                  decoration: const InputDecoration(
                    hintText: 'Type your QRCode data...',
                    prefixIcon: Icon(Icons.text_fields),
                  ),
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (value) => setQRCodeData(value),
                ),
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
