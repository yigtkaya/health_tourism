import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';

import '../../core/components/ht_icon.dart';
import '../../core/components/ht_text.dart';
import '../../core/constants/asset.dart';
import '../../core/constants/horizontal_space.dart';
import '../../product/theme/styles.dart';
import '../../product/theme/theme_manager.dart';

class AppointmentsView extends StatefulWidget {
  final String title;
  const AppointmentsView({super.key, required this.title});

  @override
  State<AppointmentsView> createState() => _AppointmentsViewState();
}

class _AppointmentsViewState extends State<AppointmentsView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
          backgroundColor: const Color(0xff2D9CDB),
          elevation: 0,
          centerTitle: true,
          leadingWidth: 42,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: HTIcon(
              iconName: AssetConstants.icons.chevronLeft,
              onPress: () {
                context.pop();
              },
              width: 24,
              height: 24,
            ),
          ),
          title: HTText(
            label: widget.title,
            style: htToolBarLabel,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpace(
                  spaceAmount: 20,
                ),
                HTText(label: "Upcoming Appointments", style: htSubTitle),
                const VerticalSpace(),
                upcomingAppointments(),
                const VerticalSpace(spaceAmount: 40),
                HTText(label: "Past Appointments", style: htSubTitle),
                const VerticalSpace(),
                pastAppointments(),
                pastAppointments(),
                pastAppointments(),
                pastAppointments(),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: const Color(0xFF123258),
                      ),
                      height: size.height * 0.006,
                      width: size.width * 0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget upcomingAppointments() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF0B4F93),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HTText(label: "January", style: htWhiteSmallLabelStyle),
                    const VerticalSpace(),
                    HTText(label: "21", style: htToolBarLabel),
                    const VerticalSpace(),
                    HTText(label: "at 4:30pm", style: htWhiteSmallLabelStyle),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
                      width: 70,
                      height: 40,
                    ),
                    Column(
                      children: [
                        HTText(
                            label: "Vera Clinic", style: htDarkBlueLargeStyle),
                        HTText(label: "İstanbul", style: htBlueLabelStyle),
                      ],
                    ),
                    const Spacer(),
                    HTIcon(iconName: AssetConstants.icons.vector),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HTText(label: "Confirmed", style: htDarkBlueNormalStyle),
                    const HorizontalSpace(
                      spaceAmount: 4,
                    ),
                    HTIcon(iconName: AssetConstants.icons.checkMark),
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF123258),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2),
                        child: Row(
                          children: [
                            HTIcon(iconName: AssetConstants.icons.chatBubble),
                            const HorizontalSpace(
                              spaceAmount: 4,
                            ),
                            HTText(label: "Chat", style: htWhiteLabelStyle),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pastAppointments() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
              width: 60,
              height: 60,
            ),
            const HorizontalSpace(),
            Column(
              children: [
                HTText(label: "Vera Clinic", style: htBoldDarkLabelStyle),
                HTText(label: "Hair Transplant", style: htSmallLabelStyle),
              ],
            ),
            const Spacer(),
            HTText(label: "£24", style: htBoldDarkLabelStyle),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                // leave a comment for clinic.
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: HTText(
                  label: "Leave a review",
                  style: htDarkBlueNormalStyle,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // open details dialog.
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0)), //this right here
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
                                    width: 60,
                                    height: 60,
                                  ),
                                  const HorizontalSpace(),
                                  Column(
                                    children: [
                                      HTText(
                                          label: "Vera Clinic",
                                          style: htBoldDarkLabelStyle),
                                      HTText(
                                          label: "Hair Transplant",
                                          style: htSmallLabelStyle),
                                    ],
                                  ),
                                  const Spacer(),
                                  HTText(
                                      label: "£24",
                                      style: htBoldDarkLabelStyle),
                                ],
                              ),
                              const VerticalSpace(),
                              const Divider(
                                color: Color(0xffd3e3f1),
                                thickness: 2,
                              ),
                              const Column(
                                children: [

                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff58a2eb),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: HTText(
                      label: "Details",
                      style: htWhiteLabelStyle,
                    ),
                  )),
            )
          ],
        ),
        const Divider(
          color: Color(0xffd3e3f1),
          thickness: 2,
        ),
      ],
    );
  }
}
