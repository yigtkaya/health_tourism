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
        resizeToAvoidBottomInset: false,
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
                const Divider(
                  color: Color(0xFFD3E3F1),
                  thickness: 1,
                ),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: HTText(label: "Confirmed", style: htDarkBlueNormalStyle),
                    ),
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
                            horizontal: 12.0, vertical: 2),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pastAppointments() {
    final TextEditingController _commentController = TextEditingController();
    final Size size = MediaQuery.of(context).size;

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
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/review_dialog.png",
                                  width: size.width * 0.8,
                                  height: size.height * 0.2,
                                ),
                                const VerticalSpace(
                                  spaceAmount: 24,
                                ),
                                Text(
                                  "Please Rate The Quality of Service!",
                                  style: htTitleStyle,
                                  textAlign: TextAlign.center,
                                ),
                                const VerticalSpace(
                                  spaceAmount: 16,
                                ),
                                // yıldızlar buraya gelecek.
                                Text(
                                    "Your comments and suggestions help us improve the service quality better!",
                                    style: htBlueLabelStyle,
                                    textAlign: TextAlign.center),
                                const VerticalSpace(
                                  spaceAmount: 24,
                                ),
                                Container(
                                  height: size.height * 0.2,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: const Color(0xFFD3E3F1)
                                          .withOpacity(0.5),
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 16.0),
                                    child: TextField(
                                      maxLines: 5,
                                      controller: _commentController,
                                      style: htDarkBlueNormalStyle,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter your comment",
                                        hintStyle: htHintTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                                const VerticalSpace(
                                  spaceAmount: 16,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF58A2EB),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: HTText(
                                        label: "Submit",
                                        style: htBoldLabelStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ), //this right here
                      );
                    },
                  );
                },
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
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0)), //this right here
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    label: "£24", style: htBoldDarkLabelStyle),
                              ],
                            ),
                            const VerticalSpace(),
                            const Divider(
                              color: Color(0xffd3e3f1),
                              thickness: 2,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const VerticalSpace(),
                                Row(
                                  children: [
                                    HTIcon(
                                      iconName: AssetConstants.icons.calendar,
                                      height: 20,
                                      width: 20,
                                    ),
                                    const HorizontalSpace(),
                                    HTText(
                                        label: "Date",
                                        style: htDarkBlueNormalStyle),
                                  ],
                                ),
                                const VerticalSpace(
                                  spaceAmount: 6,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0),
                                  child: HTText(
                                      label: "21 January, 2023",
                                      style: htSmallLabelStyle),
                                ),
                                const VerticalSpace(),
                              ],
                            ),
                            const Divider(
                              color: Color(0xffd3e3f1),
                              thickness: 2,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const VerticalSpace(),
                                Row(
                                  children: [
                                    HTIcon(
                                      iconName: AssetConstants.icons.clock,
                                      height: 20,
                                      width: 20,
                                    ),
                                    const HorizontalSpace(),
                                    HTText(
                                        label: "Time",
                                        style: htDarkBlueNormalStyle),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0),
                                  child: HTText(
                                      label: "at 4:30pm",
                                      style: htSmallLabelStyle),
                                ),
                                const VerticalSpace(),
                              ],
                            ),
                            const Divider(
                              color: Color(0xffd3e3f1),
                              thickness: 2,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    HTIcon(
                                      iconName: AssetConstants.icons.creditCard,
                                      height: 20,
                                      width: 20,
                                    ),
                                    const HorizontalSpace(),
                                    HTText(
                                        label: "Price",
                                        style: htDarkBlueNormalStyle),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32.0),
                                  child: HTText(
                                      label: "£24", style: htSmallLabelStyle),
                                ),
                                const VerticalSpace(),
                              ],
                            ),
                            const VerticalSpace(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // reschedule appointment.
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xff023167),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 12.0),
                                          child: HTText(
                                              label: "Reschedule",
                                              style: htBoldLabelStyle),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const HorizontalSpace(),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // reschedule appointment.
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xff58a2eb),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 12.0),
                                          child: HTText(
                                              label: "Message",
                                              style: htBoldLabelStyle),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const VerticalSpace(
                              spaceAmount: 16,
                            ),
                            Center(
                              child: GestureDetector(
                                  onTap: () {
                                    // cancel appointment.
                                  },
                                  child: HTText(
                                      label: "Cancel Appointment",
                                      style: htDarkBlueLargeStyle)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
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
