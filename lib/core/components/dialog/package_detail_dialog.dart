import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/product/theme/styles.dart';

import '../../../product/models/clinic.dart';
import '../../../product/models/package.dart';
import '../../../product/navigation/route_paths.dart';

class PackageDetailDialog extends StatelessWidget {
  final Clinic clinic;
  final Package package;

  const PackageDetailDialog({super.key, required this.package, required this.clinic});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: HTText(label: package.packageName, style: htSubTitle),
      content: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ListView.builder(
                    itemCount: package.packageFeatures.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          HTIcon(
                            iconName: AssetConstants.icons.checkMark,
                            width: 14,
                            height: 14,
                            color: const Color(0xff58a2eb),
                          ),
                          const HorizontalSpace(spaceAmount: 4,),
                          Expanded(
                            child: HTText(
                                label: package.packageFeatures[index],
                                style: htDarkBlueLargeStyle),
                          )
                        ],
                      );
                    }),
              ),
              const VerticalSpace(
                spaceAmount: 24,
              ),
              GestureDetector(
                onTap: () {
                  context.pushNamed(RoutePath.payment, extra: clinic);
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
                            label: 'Make An Appointment',
                            style: htBoldLabelStyle),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
