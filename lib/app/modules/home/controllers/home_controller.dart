// ignore_for_file: non_const_call_to_literal_constructor

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class HomeController extends GetxController {
  RxString qrcodeData = 'lorem ipsum dolor sit amet'.obs;
  TextEditingController qrcodeTextController = TextEditingController();
  List<String> qrcodeStyle = ['normal', 'smooth', 'dotted'];
  RxString qrcodeStyleValue = 'smooth'.obs;
  Rx<Color> foregroundColor = Colors.black.obs;
  Rx<Color> backgroundColor = Colors.white.obs;
  Rx<PrettyQrDecoration> prettyQrDecoration = PrettyQrDecoration().obs;

  @override
  void onInit() {
    super.onInit();
    prettyQrDecoration.value = PrettyQrDecoration(
      background: backgroundColor.value,
      shape: PrettyQrSmoothSymbol(
        color: foregroundColor.value,
      ),
    );
  }
}
