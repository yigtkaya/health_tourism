import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:path/path.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/components/ht_icon.dart';
import '../../core/components/ht_text.dart';
import '../../core/constants/asset.dart';
import '../../core/constants/horizontal_space.dart';
import '../../product/navigation/route_paths.dart';
import '../../product/theme/styles.dart';

class ClinicDetailView extends StatefulWidget {
  final String clinicId;
  const ClinicDetailView({super.key, required this.clinicId});

  @override
  State<ClinicDetailView> createState() => _ClinicDetailViewState();
}

class _ClinicDetailViewState extends State<ClinicDetailView> {
  int activeIndex = 0;
  final clinicImages = [
    "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
    "https://www.fue-hlc.com/wp-content/uploads/2018/01/unnamed-5-1-425x200.jpg",
    "https://drfatihkoroglu.com/wp-content/uploads/2022/09/clinica-para-injerto-capilar.jpg",
    "https://iadsb.tmgrup.com.tr/29d1f0/1200/627/0/147/1800/1087?u=https://idsb.tmgrup.com.tr/2019/03/03/high-quality-low-cost-drives-hair-transplant-sector-1551645283861.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    final controller = CarouselController();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CarouselSlider.builder(
                    carouselController: controller,
                    itemCount: clinicImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final urlImage = clinicImages[index];
                      return buildImage(urlImage, index, context);
                    },
                    options: CarouselOptions(
                        height: 400,
                        autoPlay: true,
                        enableInfiniteScroll: false,
                        autoPlayAnimationDuration: Duration(seconds: 2),
                        viewportFraction: 1,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index))),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: buildIndicator(),
                ),
              ],
            ),
            const VerticalSpace(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      HTText(label: "Vera Clinic", style: htTitleStyle),
                      const Spacer(),
                      HTIcon(
                        iconName: AssetConstants.icons.star,
                        width: 20,
                        height: 20,
                      ),
                      const HorizontalSpace(
                        spaceAmount: 3,
                      ),
                      HTText(label: "4.5", style: htBlueLabelStyle),
                      const HorizontalSpace(
                        spaceAmount: 6,
                      ),
                    ],
                  ),
                  const VerticalSpace(),
                  HTText(label: "Istanbul, Türkiye", style: htBlueLabelStyle),
                ],
              ),
            ),
            const VerticalSpace(),
            const Divider(
              height: 1,
              thickness: 2,
              color: Color(0x33000000),
            ),
            const VerticalSpace(),
            buildInformation(size),
          ],
        ),
      )),
    );
  }

  Widget buildInformation(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HTText(label: "About", style: htDarkBlueLargeStyle),
          const VerticalSpace(),
          const ReadMoreText(
              "placehoplaceholderplac"
              "eholderplaceholderplaceholderplaceholderplaceho"
              "ülderplaceholderplaceholderplaceholderlderplaceholderpl"
              "aceholderplaceholderplaceholderaceholderplaceholderplaceholdera"
              "ceholaceholderplaceholderplaceholderaceholderplaceholderplacehold"
              "erderaceholderplaceholderplaceholderaceholderplaceholderplaceholderpl"
              "acehoaceholderplaceholderplaceholderaceholderplaceholderplaceholderlderplacehol"
              "deraceholderplaceholderplaceholderaceholderplaceholderplaceholder",
              style: htLabelBlackStyle,
              trimLines: 4,
              colorClickableText: Colors.blue,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Read more',
              trimExpandedText: ' show less'),
          const VerticalSpace(),
          HTText(label: "Operations", style: htDarkBlueLargeStyle),
          const VerticalSpace(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageHolder(size),
                  const HorizontalSpace(),
                  ImageHolder(size),
                  const HorizontalSpace(),
                  ImageHolder(size),
                ],
              ),
            ),
          ),
          const VerticalSpace(),
          HTText(label: "Packages", style: htDarkBlueLargeStyle),
          const VerticalSpace(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                createPackages(size),
                const HorizontalSpace(),
                createPackages(size),
              ],
            ),
          ),
          const VerticalSpace(
            spaceAmount: 24,
          ),
          Row(
            children: [
              HTText(label: "Reviews(18)", style: htTitleStyle),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to reviews page
                },
                child: SizedBox(
                  child:
                      HTText(label: "View All", style: htDarkBlueNormalStyle),
                ),
              ),
              const HorizontalSpace(),
              HTIcon(iconName: AssetConstants.icons.chevronRight)
            ],
          )
        ],
      ),
    );
  }

  Widget createPackages(Size size) {
    return GestureDetector(
      onTap: () {
        /// TODO: Navigate to package detail page ??
      },
      child: Container(
        width: size.width * 0.43,
        decoration: const BoxDecoration(
          color: Color(0xffd3e9ff),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                  child: HTText(
                      label: "PackageTitle", style: htDarkBlueLargeStyle)),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HTText(label: "- Maximum Graft", style: htLabelBlackStyle),
                  HTText(
                      label: "- Gives 100% satisfaction guarantee",
                      style: htLabelBlackStyle),
                  HTText(
                      label: "- 2 Nights stay in the Hotel",
                      style: htLabelBlackStyle),
                  HTText(label: "- Checkup", style: htLabelBlackStyle),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ImageHolder(Size size) => Container(
        height: size.height * 0.12,
        width: size.width * 0.28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: const DecorationImage(
              image: NetworkImage(
                  "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg"),
              fit: BoxFit.cover),
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: clinicImages.length,
        effect: const ExpandingDotsEffect(
            dotWidth: 6,
            dotHeight: 6,
            expansionFactor: 2,
            spacing: 4,
            activeDotColor: Colors.blue,
            dotColor: Colors.grey),
      );

  Widget buildImage(String urlImage, int index, BuildContext context) =>
      ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(22),
          bottomLeft: Radius.circular(22),
        ),
        child: GestureDetector(
            onTap: () {
              context.pushNamed(RoutePath.fullscreenImage, queryParameters: {
                "imageUrl": urlImage,
              });
            },
            child: Image.network(urlImage, fit: BoxFit.cover)),
      );
}
