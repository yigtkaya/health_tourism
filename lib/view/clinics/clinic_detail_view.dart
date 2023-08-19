import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';
import '../../core/components/dialog/package_detail_dialog.dart';
import '../../core/components/ht_icon.dart';
import '../../core/components/ht_text.dart';
import '../../core/components/review_card.dart';
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
  final controller = CarouselController();

  final clinicImages = [
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
    "https://www.fue-hlc.com/wp-content/uploads/2018/01/unnamed-5-1-425x200.jpg",
    "https://drfatihkoroglu.com/wp-content/uploads/2022/09/clinica-para-injerto-capilar.jpg",
    "https://iadsb.tmgrup.com.tr/29d1f0/1200/627/0/147/1800/1087?u=https://idsb.tmgrup.com.tr/2019/03/03/high-quality-low-cost-drives-hair-transplant-sector-1551645283861.jpg"
  ];
  final reviews = [
    ReviewCard(),
    ReviewCard(),
    ReviewCard(),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          context.push(RoutePath.payment);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
              height: size.height * 0.06,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xff58a2eb)),
              child: Center(
                child: HTText(
                    label: 'Make An Appointment', style: htBoldLabelStyle),
              )),
        ),
      ),
      body: SafeArea(
        top: false,
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
                          height: size.height * 0.6,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          autoPlayAnimationDuration: const Duration(seconds: 2),
                          viewportFraction: 1,
                          enlargeCenterPage: false,
                          onPageChanged: (index, reason) =>
                              setState(() => activeIndex = index))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: buildIndicator(),
                  ),
                  Positioned(
                    top: 52,
                    left: 32,
                    child: HTIcon(
                      iconName: AssetConstants.icons.chevronLeft,
                      width: 20,
                      height: 20,
                      color: Colors.white,
                      onPress: () {
                        context.pop();
                      },
                    ),
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
                    Row(
                      children: [
                        HTText(
                            label: "Istanbul, Türkiye", style: htBlueLabelStyle),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            // route to contact create chat room and start chatting
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF123258),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 2),
                              child: Row(
                                children: [
                                  HTIcon(
                                      iconName: AssetConstants.icons.chatBubble),
                                  const HorizontalSpace(
                                    spaceAmount: 4,
                                  ),
                                  HTText(label: "Chat", style: htWhiteLabelStyle),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const VerticalSpace(),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0x33000000),
              ),
              const VerticalSpace(),
              buildInformation(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInformation(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HTText(label: "About", style: htSubTitle),
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
          const VerticalSpace(
            spaceAmount: 20,
          ),
          HTText(label: "Operations", style: htSubTitle),
          const VerticalSpace(
            spaceAmount: 12,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  operationImageHolder(size),
                  const HorizontalSpace(),
                  operationImageHolder(size),
                  const HorizontalSpace(),
                  operationImageHolder(size),
                  const HorizontalSpace(),
                  operationImageHolder(size),
                  const HorizontalSpace(),
                  operationImageHolder(size),
                ],
              ),
            ),
          ),
          const VerticalSpace(
            spaceAmount: 20,
          ),
          HTText(label: "Packages", style: htSubTitle),
          const VerticalSpace(
            spaceAmount: 12,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                createPackages(size),
                const HorizontalSpace(),
                createPackages(size),
                const HorizontalSpace(),
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
              HTText(label: "Reviews (18)", style: htTitleStyle),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.push(RoutePath.reviews);
                },
                child: SizedBox(
                  child:
                      HTText(label: "View All", style: htDarkBlueNormalStyle),
                ),
              ),
              const HorizontalSpace(),
              HTIcon(iconName: AssetConstants.icons.chevronRight)
            ],
          ),
          const VerticalSpace(
            spaceAmount: 12,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return reviews[index];
            },
          ),
        ],
      ),
    );
  }

  List details = [
    "Maximum Graft",
    "Gives 100% satisfaction guarantee",
    "2 Nights stay in the Hotel",
    "Checkup"
  ];
  Widget createPackages(Size size) {
    return GestureDetector(
      onTap: () {
        /// TODO: Navigate to package detail page ??
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return PackageDetailDialog(
                packageDetailList: details,
              );
            });
      },
      child: Container(
        width: size.width * 0.45,
        decoration: const BoxDecoration(
          color: Color(0xffd3e9ff),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6),
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
              padding: EdgeInsets.all(14.0),
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

  Widget operationImageHolder(Size size) => Container(
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

  Widget buildImage(String urlImage, int index, BuildContext context) {
    if (urlImage.contains(".mp4")) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(22),
          bottomLeft: Radius.circular(22),
        ),
        child: VideoPlayerDemo(url: urlImage, corousel: controller),
      );
    }
    return ClipRRect(
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
}

class VideoPlayerDemo extends StatefulWidget {
  final String url;
  final CarouselController corousel;

  const VideoPlayerDemo({super.key, required this.url, required this.corousel});

  @override
  State<VideoPlayerDemo> createState() => _VideoPlayerDemoState();
}

class _VideoPlayerDemoState extends State<VideoPlayerDemo> {
  late VideoPlayerController controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: false,
      looping: false,
      autoInitialize: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
    listener();
  }

  void listener() {
    controller.addListener(() {
      if(controller.value.position == const Duration(seconds: 0, minutes: 0, hours: 0)) {
        print('video Started');
      }

      if(!controller.value.isPlaying &&controller.value.isInitialized &&
          (controller.value.duration ==controller.value.position)) {
        print('video Ended');
        widget.corousel.nextPage();
      }
    });
  }
  @override
  void dispose() {
    controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }
}
