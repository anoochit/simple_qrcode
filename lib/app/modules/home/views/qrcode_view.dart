import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:simply_qrcode/app/modules/home/controllers/home_controller.dart';

class QRCodeView extends GetView<HomeController> {
  const QRCodeView({super.key, required this.isLandscape});

  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.5;
    double height = MediaQuery.of(context).size.width * 0.5;

    if (isLandscape == true) {
      width = MediaQuery.of(context).size.height * 0.8;
      height = MediaQuery.of(context).size.height * 0.8;
    }

    return Obx(
      () => Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Container(
          color: controller.backgroundColor.value,
          padding: const EdgeInsets.all(8.0),
          child: PrettyQrView.data(
            data: controller.qrcodeData.value,
            errorCorrectLevel: QrErrorCorrectLevel.L,
            decoration: controller.prettyQrDecoration.value,
          ),
        ),
      ),
    );
  }
}
