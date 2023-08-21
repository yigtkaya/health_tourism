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
import '../../product/models/clinic.dart';
import '../../product/models/package.dart';
import '../../product/navigation/route_paths.dart';
import '../../product/theme/styles.dart';

class ClinicDetailView extends StatefulWidget {
  final Clinic clinic;
  const ClinicDetailView({super.key, required this.clinic});

  @override
  State<ClinicDetailView> createState() => _ClinicDetailViewState();
}

class _ClinicDetailViewState extends State<ClinicDetailView> {
  int activeIndex = 0;
  final controller = CarouselController();
  List packages = [];

  final reviews = [
    ReviewCard(),
    ReviewCard(),
    ReviewCard(),
  ];

  @override
  void initState() {
    super.initState();
    extractPackages();
  }

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
                    itemCount: widget.clinic.imageUrls.length,
                    itemBuilder: (context, index, realIndex) {
                      final urlImage = widget.clinic.imageUrls[index];
                      return buildImage(urlImage, index, context);
                    },
                    options: CarouselOptions(
                      height: size.height * 0.5,
                      autoPlay: false,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      viewportFraction: 1,
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index),
                    ),
                  ),
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
                        HTText(label: widget.clinic.name, style: htTitleStyle),
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
                            label: widget.clinic.averageRating.toString(),
                            style: htBlueLabelStyle),
                        const HorizontalSpace(
                          spaceAmount: 6,
                        ),
                      ],
                    ),
                    const VerticalSpace(),
                    Row(
                      children: [
                        HTText(
                            label:
                                "${widget.clinic.city}, ${widget.clinic.country}",
                            style: htBlueLabelStyle),
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
                                      iconName:
                                          AssetConstants.icons.chatBubble),
                                  const HorizontalSpace(
                                    spaceAmount: 4,
                                  ),
                                  HTText(
                                      label: "Chat", style: htWhiteLabelStyle),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HTText(label: "About", style: htSubTitle),
          const VerticalSpace(),
          ReadMoreText(widget.clinic.about,
              style: htLabelBlackStyle,
              trimLines: 4,
              colorClickableText: Colors.blue,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Read more',
              trimExpandedText: ' show less'),
          const VerticalSpace(
            spaceAmount: 32,
          ),
          HTText(label: "Operations", style: htSubTitle),
          const VerticalSpace(
            spaceAmount: 12,
          ),
          SizedBox(
            height: size.height * 0.15,
            child: ListView.builder(
                itemCount: widget.clinic.operationImageUrls.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: operationImageHolder(
                        widget.clinic.operationImageUrls[index], size),
                  );
                }),
          ),
          const VerticalSpace(
            spaceAmount: 32,
          ),
          HTText(label: "Packages", style: htSubTitle),
          const VerticalSpace(
            spaceAmount: 12,
          ),
          SizedBox(
            height: size.height * 0.15,
            child: ListView.builder(
                itemCount: packages.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: createPackages(size, packages[index]),
                  );
                }),
          ),
          const VerticalSpace(
            spaceAmount: 32,
          ),
          Row(
            children: [
              HTText(
                  label: "Reviews (${widget.clinic.reviewCount})",
                  style: htTitleStyle),
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

  void extractPackages() {
    final details = widget.clinic.packages;
    for (final package in details) {
      packages.add(Package.fromData(package));
    }
  }

  Widget createPackages(Size size, Package package) {
    return GestureDetector(
      onTap: () {
        /// TODO: Navigate to package detail page ??
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return PackageDetailDialog(
                package: package,
              );
            });
      },
      child: Container(
        width: size.width * 0.46,
        decoration: const BoxDecoration(
          color: Color(0xffd3e9ff),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: HTText(
                      label: package.packageName, style: htDarkBlueLargeStyle)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  child: ListView.builder(
                    itemCount: package.packageFeatures.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                    return Row(
                      children: [
                        HTIcon(iconName: AssetConstants.icons.checkMark),
                        const HorizontalSpace(spaceAmount: 4),
                        HTText(
                            label: package.packageFeatures[index],
                            style: htLabelBlackStyle),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget operationImageHolder(String url, Size size) => GestureDetector(
    onTap: () {
      context.pushNamed(RoutePath.fullscreenImage, queryParameters: {
        "imageUrl": url,
      });
    },
    child: Container(
          height: size.height * 0.12,
          width: size.width * 0.28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
          ),
        ),
  );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.clinic.imageUrls.length,
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
      if (controller.value.position ==
          const Duration(seconds: 0, minutes: 0, hours: 0)) {
        print('video Started');
      }

      if (!controller.value.isPlaying &&
          controller.value.isInitialized &&
          (controller.value.duration == controller.value.position)) {
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
