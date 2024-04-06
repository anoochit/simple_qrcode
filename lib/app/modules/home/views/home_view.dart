// ignore_for_file: non_const_call_to_literal_constructor, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'landscape_view.dart';
import 'portrait_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const PortraitView();
        }

        return const LandscapeView();
      },
    );
  }
}
