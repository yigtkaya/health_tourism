import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/dialog/appointment_detail_dialog.dart';
import 'package:health_tourism/core/components/dialog/leave_comment_dialog.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import '../../core/components/ht_icon.dart';
import '../../core/components/ht_text.dart';
import '../../core/constants/asset.dart';
import '../../core/constants/horizontal_space.dart';
import '../../product/models/appointment.dart';
import '../../product/models/user.dart';
import '../../product/theme/styles.dart';

class AppointmentsView extends StatefulWidget {
  final User user;
  const AppointmentsView({super.key, required this.user});

  @override
  State<AppointmentsView> createState() => _AppointmentsViewState();
}

class _AppointmentsViewState extends State<AppointmentsView> {
  List pastAppointmentsList = [];
  List upcomingAppointmentsList = [];
  late bool anyAppointment;
  late User secUser;

  @override
  void initState() {
    super.initState();
    if (widget.user.appointments.isEmpty) {
      anyAppointment = false;
    } else {
      anyAppointment = true;
      extractAppointments(widget.user);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          label: "Appointments",
          style: htToolBarLabel,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: anyAppointment
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpace(
                      spaceAmount: 20,
                    ),
                    buildUpcomingAppointmentView(),
                    const Divider(
                      color: Color(0xFFD3E3F1),
                      thickness: 1,
                    ),
                    const VerticalSpace(spaceAmount: 40),
                    buildPastAppointmentView(),
                    const Spacer(),
                  ],
                )
              : Center(
                  child: HTText(
                    label: "You have no appointments yet",
                    style: htHintTextDarkStyle,
                  ),
                ),
        ),
      ),
    );
  }

  Widget buildUpcomingAppointmentView() {
    return upcomingAppointmentsList.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HTText(label: "Upcoming Appointments", style: htSubTitle),
              const VerticalSpace(),
              ListView.builder(
                  itemCount: upcomingAppointmentsList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return upcomingAppointments(
                        upcomingAppointmentsList[index]);
                  }),
            ],
          );
  }

  Widget buildPastAppointmentView() {
    return pastAppointmentsList.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpace(spaceAmount: 40),
              HTText(label: "Past Appointments", style: htSubTitle),
              const VerticalSpace(),
              ListView.builder(
                  itemCount: pastAppointmentsList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return pastAppointments(pastAppointmentsList[index]);
                  }),
            ],
          );
  }

  Widget upcomingAppointments(Appointment appointment) {
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
                    const EdgeInsets.symmetric(horizontal: 26.0, vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HTText(
                        label: monthFromInt(appointment.date.month),
                        style: htWhiteSmallLabelStyle),
                    const VerticalSpace(),
                    HTText(
                        label: "${appointment.date.day}",
                        style: htToolBarLabel),
                    const VerticalSpace(),
                    HTText(
                        label: "${appointment.date.year}",
                        style: htWhiteSmallLabelStyle),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 7,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HTText(
                            label: appointment.clinicName,
                            style: htDarkBlueLargeStyle),
                        HTText(
                            label: appointment.clinicCity,
                            style: htBlueLabelStyle),
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
                      child: HTText(
                          label: "Confirmed", style: htDarkBlueNormalStyle),
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

  Widget pastAppointments(Appointment appointment) {
    final TextEditingController _commentController = TextEditingController();

    return Column(
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
              children: [
                HTText(
                    label: appointment.clinicName, style: htBoldDarkLabelStyle),
                HTText(label: appointment.operation, style: htSmallLabelStyle),
              ],
            ),
            const Spacer(),
            HTText(
                label: appointment.price.toString(),
                style: htBoldDarkLabelStyle),
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
                      return LeaveCommentDialog(
                          commentController: _commentController);
                    },
                  );
                },
                child: HTText(
                  label: appointment.reviewed ? "" : "Leave a review",
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
                    return const AppointmentDetailDialog();
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

  String monthFromInt(int index) {
    switch (index) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "July";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      default:
        return "Dec";
    }
  }

  void extractAppointments(User user) {
    for (final i in user.appointments) {
      final appointment = Appointment.fromJson(i);
      if (appointment.date.isAfter(DateTime.now())) {
        upcomingAppointmentsList.add(appointment);
      } else {
        pastAppointmentsList.add(appointment);
      }
    }
  }
}
