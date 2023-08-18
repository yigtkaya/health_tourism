import 'package:flutter/material.dart';

import '../../../product/theme/styles.dart';
import '../../constants/asset.dart';
import '../../constants/horizontal_space.dart';
import '../../constants/vertical_space.dart';
import '../ht_icon.dart';
import '../ht_text.dart';

class AppointmentDetailDialog extends StatelessWidget {
  const AppointmentDetailDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
