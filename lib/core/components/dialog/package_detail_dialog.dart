import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/product/theme/styles.dart';

import '../../../product/navigation/route_paths.dart';

class PackageDetailDialog extends StatelessWidget {
  final List packageDetailList;

  const PackageDetailDialog({super.key, required this.packageDetailList});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
      ),
      title: const Text("Package Title"),
      content: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              itemCount: packageDetailList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                      children: [
                        HTIcon(iconName: AssetConstants.icons.checkMark),
                        const HorizontalSpace(),
                        HTText(label: packageDetailList[index], style: htDarkBlueLargeStyle)
                      ],
                  );
            }),
            const VerticalSpace(spaceAmount: 24,),
            GestureDetector(
              onTap: () {
                context.push(RoutePath.payment);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                    width: double.maxFinite,
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xff58a2eb)),
                    child: Center(
                      child: HTText(
                          label: 'Make An Appointment', style: htBoldLabelStyle),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
