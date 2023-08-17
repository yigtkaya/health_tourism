import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';

import '../../core/components/clinic_card.dart';
import '../../core/components/ht_text.dart';
import '../../product/theme/styles.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: const Color(0xff2D9CDB),
        elevation: 0,
        centerTitle: true,
        title: HTText(
          label: "VoyEsthetic",
          style: htToolBarLabel,
        ),
      ),
        body: SafeArea(
            child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffe8f3f1).withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Row(
                children: [
                  HTIcon(
                      iconName: AssetConstants.icons.search,
                      width: 24,
                      height: 24),
                  const HorizontalSpace(),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search by Name",
                        hintStyle: htHintTextStyle,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const VerticalSpace(
          spaceAmount: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  /// TODO: Filter
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: const Color(0xffe8f3f1), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    child: Row(
                      children: [
                        HTIcon(
                            iconName: AssetConstants.icons.calendar,
                            width: 24,
                            height: 24),
                        const HorizontalSpace(),
                        HTText(label: "Filter", style: htHintTextStyle),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  /// TODO: Sort
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: const Color(0xffe8f3f1), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    child: Row(
                      children: [
                        HTIcon(
                          iconName: AssetConstants.icons.sort,
                          width: 24,
                          height: 24,
                          color: const Color(0xff8fc2f3),
                        ),
                        const HorizontalSpace(),
                        HTText(label: "Sort", style: htHintTextStyle),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: cards.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return cards[index];
              }),
        )
      ],
    )));
  }

  List cards = [
    const ClinicCard(
      clinicId: "1",
      imgUrl:
          "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
      clinicName: "Medico Clinic",
      clinicAddress: "Istanbul, Turkey",
      rating: 4.5,
      reviewCount: 100,
    ),
    const ClinicCard(
      clinicId: "1",
      imgUrl:
          "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
      clinicName: "Medico Clinic",
      clinicAddress: "Istanbul, Turkey",
      rating: 4.5,
      reviewCount: 100,
    ),
    const ClinicCard(
      clinicId: "1",
      imgUrl:
          "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
      clinicName: "Medico Clinic",
      clinicAddress: "Istanbul, Turkey",
      rating: 4.5,
      reviewCount: 100,
    ),
    const ClinicCard(
      clinicId: "1",
      imgUrl:
          "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
      clinicName: "Medico Clinic",
      clinicAddress: "Istanbul, Turkey",
      rating: 4.5,
      reviewCount: 100,
    ),
    const ClinicCard(
      clinicId: "1",
      imgUrl:
          "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
      clinicName: "Medico Clinic",
      clinicAddress: "Istanbul, Turkey",
      rating: 4.5,
      reviewCount: 100,
    ),
    const ClinicCard(
      clinicId: "1",
      imgUrl:
          "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
      clinicName: "Medico Clinic",
      clinicAddress: "Istanbul, Turkey",
      rating: 4.5,
      reviewCount: 100,
    ),
    const ClinicCard(
      clinicId: "1",
      imgUrl:
          "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
      clinicName: "Medico Clinic",
      clinicAddress: "Istanbul, Turkey",
      rating: 4.5,
      reviewCount: 100,
    ),
    const ClinicCard(
      clinicId: "1",
      imgUrl:
          "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
      clinicName: "Medico Clinic",
      clinicAddress: "Istanbul, Turkey",
      rating: 4.5,
      reviewCount: 100,
    ),
    const ClinicCard(
      clinicId: "1",
      imgUrl:
          "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
      clinicName: "Medico Clinic",
      clinicAddress: "Istanbul, Turkey",
      rating: 4.5,
      reviewCount: 100,
    ),
  ];
}
