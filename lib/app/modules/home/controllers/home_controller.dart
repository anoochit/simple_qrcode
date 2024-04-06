import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxString qrcodeData = 'lorem ipsum dolor sit amet'.obs;
  RxBool qrcodeRounded = false.obs;

  RxBool qrcodeStyle = true.obs;

  TextEditingController qrcodeTextController = TextEditingController();
}
