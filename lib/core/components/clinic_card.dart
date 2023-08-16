import 'package:flutter/material.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';
import 'package:health_tourism/product/theme/styles.dart';

class ClinicCard extends StatefulWidget {
  final String imgUrl;
  final String clinicName;
  final String clinicAddress;
  final int reviewCount;
  final double rating;

  const ClinicCard(
      {super.key,
      required this.imgUrl,
      required this.clinicName,
      required this.clinicAddress,
      required this.reviewCount,
      required this.rating});

  @override
  State<ClinicCard> createState() => _ClinicCardState();
}

class _ClinicCardState extends State<ClinicCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
              margin: const EdgeInsets.only(
                  bottom: 6.0), //Same as `blurRadius` i guess
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFFFFFFF),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 19.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      widget.imgUrl,
                      width: size.width * 1,
                      height: size.height * 0.22,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            HTText(
                                label: widget.clinicName,
                                style: htDarkBlueLargeStyle),
                            const Spacer(),
                            HTIcon(
                              iconName: AssetConstants.icons.star,
                              width: 20,
                              height: 20,
                            ),
                            const HorizontalSpace(
                              spaceAmount: 3,
                            ),
                            HTText(
                                label: widget.rating.toString(),
                                style: htDarkBlueLargeStyle),
                            const HorizontalSpace(spaceAmount: 6,),
                            HTText(
                                label: '(${widget.reviewCount.toString()})',
                                style: htSmallLabelStyle),
                          ],
                        ),
                        HTText(
                            label: widget.clinicAddress,
                            style: htSmallLabelStyle),
                      ],
                    ),
                  )
                ],
              )),
        )
      ],
    );
  }
}
