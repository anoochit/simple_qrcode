import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simply_qrcode/app/modules/home/controllers/home_controller.dart';

import 'qrcode_data_view.dart';
import 'qrcode_view.dart';
import 'save_button_view.dart';

class LandscapeView extends GetView<HomeController> {
  const LandscapeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRCode Generator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const QRCodeView(isLandscape: true),
          const VerticalDivider(width: 1.0),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: const [
                QRCodeDataView(),
                SaveButtonView(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
