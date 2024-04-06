import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'qrcode_data_view.dart';
import 'qrcode_view.dart';
import 'save_button_view.dart';

class PortraitView extends GetView<HomeController> {
  const PortraitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRCode Generator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: const [
          Gap(8.0),
          QRCodeView(isLandscape: false),
          Gap(8.0),
          Divider(),
          QRCodeDataView(),
          SaveButtonView()
        ],
      ),
    );
  }
}
