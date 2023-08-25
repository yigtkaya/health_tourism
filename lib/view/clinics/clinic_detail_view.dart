import 'package:appinio_video_player/appinio_video_player.dart';
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
  List<Package> packages = [];

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
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          context.pushNamed(RoutePath.payment, extra: widget.clinic);
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    color: const Color(0xff123258),
                    onPress: () {
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
            const VerticalSpace(),
            buildInformation(size),
          ],
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
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
            thickness: 2,
            color: Color(0xfff3f3f3),
          ),
          const VerticalSpace(),
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
          Container(
            constraints: BoxConstraints(
              maxHeight: size.height * 0.36,
            ),
            child: Expanded(
              child: ListView.builder(
                  itemCount: packages.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: packageCard(packages[index]),
                    );
                  }),
            ),
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
                  child: HTText(
                      label: "View All", style: htDarkBlueNormalStyle),
                ),
              ),
              const HorizontalSpace(),
              HTIcon(iconName: AssetConstants.icons.chevronRight)
            ],
          ),
          const VerticalSpace(
            spaceAmount: 16,
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return reviews[index];
            },
          ),
        ],
      ),
    );
  }

  void extractPackages() {
    final details = widget.clinic.packages;
    for (final package in details) {
      packages.add(Package.fromData(package));
    }
  }

  Widget packageCard(Package package) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return PackageDetailDialog(
                clinic: widget.clinic,
                package: package,
              );
            });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xff58a2eb)),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              HTText(
                label: package.packageName,
                style: htBlueLabelStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w600, color: const Color(
                    0xff58a2eb)),
              ),
              const VerticalSpace(
                spaceAmount: 8,
              ),
              HTText(
                  label: package.packageDescription,
                  style: htDarkBlueLargeStyle),
              const VerticalSpace(),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xfff3f3f3),
              ),
              const VerticalSpace(),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: package.packageFeatures.length,
                  shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HTIcon(
                        iconName: AssetConstants.icons.checkMark,
                        color: const Color(0xff58a2eb),
                        width: 14,
                        height: 14,
                      ),
                      const HorizontalSpace(
                        spaceAmount: 4,
                      ),
                      Expanded(
                        child: Text(
                            package.packageFeatures[index],
                          style: htDarkBlueLargeStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400
                            ),),
                      ),
                    ],
                  );
                }),
              )
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
      return SafeArea(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(22),
            bottomLeft: Radius.circular(22),
          ),
          child: VideoPlayerDemo(url: urlImage, corousel: controller),
        ),
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
  late CustomVideoPlayerController _customVideoPlayerController;
  late ChewieController _chewieController;
  bool isVideoPlaying = false;
  // crete a decider function or widget to show loading indicator or play button
  Widget overlay(bool isInitialized) {
    if (!isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return const Center(
      child: Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 50,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((value) => setState(() {
            _customVideoPlayerController = CustomVideoPlayerController(
              context: context,
              customVideoPlayerSettings: const CustomVideoPlayerSettings(
                customAspectRatio: 4 / 3,
                showPlayButton: true,
                autoFadeOutControls: true,
                durationAfterControlsFadeOut: Duration(milliseconds: 800),
                settingsButtonAvailable: false,
                durationRemainingTextStyle:
                    TextStyle(color: Colors.transparent),
                enterFullscreenButton: SizedBox.shrink(),
                controlBarAvailable: true,
                  customVideoPlayerProgressBarSettings: CustomVideoPlayerProgressBarSettings(
                    bufferedColor: Colors.grey,
                    progressBarHeight: 5,
                    backgroundColor: Colors.grey,
                  )
              ),
              videoPlayerController: controller,
            );
          }));

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
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomVideoPlayer(
        customVideoPlayerController: _customVideoPlayerController);
  }
}
