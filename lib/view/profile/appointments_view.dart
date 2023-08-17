import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';

import '../../core/components/ht_text.dart';
import '../../product/theme/styles.dart';

class AppointmentsView extends StatefulWidget {
  final String title;
  const AppointmentsView({super.key, required this.title});

  @override
  State<AppointmentsView> createState() => _AppointmentsViewState();
}

class _AppointmentsViewState extends State<AppointmentsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
          backgroundColor: const Color(0xff2D9CDB),
          elevation: 0,
          centerTitle: true,
          title: HTText(
            label: widget.title,
            style: htToolBarLabel,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const VerticalSpace(),
              HTText(label: "Upcoming Appointments", style: htSubTitle),
              const VerticalSpace(),
              HTText(label: "Past Appointments", style: htSubTitle),
            ],
          ),
        )
    );
  }

  Widget pastAppointments() {
    return Column(
      children: [
        Row(
          children: [

          ],
        ),
        Row(
          children: [

          ],
        ),
      ],
    );
  }
}
