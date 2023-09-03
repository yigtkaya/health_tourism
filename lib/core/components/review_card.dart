import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/components/ht_text.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:readmore/readmore.dart';

import '../../product/theme/styles.dart';
import '../constants/horizontal_space.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({super.key});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
                width: 40,
                height: 40,
              ),
              const HorizontalSpace(),
              HTText(label: "John Doe", style: htDarkBlueLargeStyle),
              const Spacer(),
              HTIcon(iconName: AssetConstants.icons.star),
              const HorizontalSpace(spaceAmount: 4),
              HTText(label: "4.5", style: htBlueLabelStyle),
            ],
          ),
          const VerticalSpace(),
          ReadMoreText(
              "placehoplaceholderplac"
              "eholderplaceholderplaceholderplaceholderplaceho"
              "ülderplaceholderplaceholderplaceholderlderplaceholderpl"
              "aceholderplaceholderplaceholderaceholderplaceholderplaceholdera",
              style: htBlueLabelStyle,
              trimLines: 4,
              colorClickableText: Colors.blue,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Read more',
              trimExpandedText: ' show less'),
          const VerticalSpace(),
          Row(
            children: [
              HTText(label: "12.12.2021", style: htDarkBlueNormalStyle),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // TODO: Put in a reply
                },
                child: SizedBox(
                  child:
                  HTText(label: "Reply", style: htDarkBlueLargeStyle),
                ),
              ),
              const HorizontalSpace(),
              HTIcon(iconName: AssetConstants.icons.chevronRight)
            ],
          ),
          const VerticalSpace(),
          const Divider(
            color: Color(0xffd3e3f1),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
