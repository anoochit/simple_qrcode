import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simply_qrcode/app/modules/home/controllers/home_controller.dart';

class SelectedColorView extends GetView<HomeController> {
  SelectedColorView({super.key, required this.onChanged, required this.color});

  final ValueChanged onChanged;
  final Color color;

  final List<Color> colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.black,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showColorDialog(context),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(44),
            border: Border.all(
              color: Colors.grey.shade400,
            ),
          ),
          width: 44.0,
          height: 44.0,
        ),
      ),
    );
  }

  showColorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Wrap(
          children: colors
              .map((e) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipOval(
                      child: InkWell(
                        onTap: () {
                          onChanged(e);
                          Get.back();
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          color: e,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
