import 'package:flutter/material.dart';
import 'package:health_tourism/product/models/appointment.dart';

import '../../../product/theme/styles.dart';
import '../../constants/asset.dart';
import '../../constants/horizontal_space.dart';
import '../../constants/vertical_space.dart';
import '../ht_icon.dart';
import '../ht_text.dart';

class AppointmentDetailDialog extends StatelessWidget {
  final Appointment appointment;
  const AppointmentDetailDialog({super.key, required this.appointment});

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
                  appointment.profilePhoto,
                  width: 60,
                  height: 60,
                ),
                const HorizontalSpace(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HTText(
                        label: appointment.clinicName,
                        style: htBoldDarkLabelStyle),
                    HTText(
                        label: appointment.operation,
                        style: htSmallLabelStyle),
                  ],
                ),
                const Spacer(),
                HTText(
                    label: appointment.price.toString(), style: htBoldDarkLabelStyle),
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
                      label: appointment.date.toString(),
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
                      label: appointment.price.toString(), style: htSmallLabelStyle),
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
