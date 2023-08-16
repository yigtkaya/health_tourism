import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';

import '../../core/components/ht_text.dart';
import '../../core/components/review_card.dart';
import '../../product/theme/styles.dart';

class ReviewsView extends StatefulWidget {
  const ReviewsView({super.key});

  @override
  State<ReviewsView> createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final reviews = [
      ReviewCard(),
      ReviewCard(),
      ReviewCard(),
      ReviewCard(),
      ReviewCard(),
      ReviewCard(),
      ReviewCard(),
      ReviewCard(),
      ReviewCard(),
      ReviewCard(),
    ];
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xff2D9CDB),
          ),
          height: size.height * 0.07,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HTIcon(
                  iconName: AssetConstants.icons.chevronLeft,
                  onPress: () => context.pop(),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: HTText(label: "Reviews", style: htToolBarLabel),
                  ),
                ),
              ],
            ),
          ),
        ),
        const VerticalSpace(),
        Expanded(
          child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return reviews[index];
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6.0, bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: const Color(0xFF123258),
            ),
            height: size.height * 0.006,
            width: size.width * 0.4,
          ),
        ),
      ],
    )));
  }
}
