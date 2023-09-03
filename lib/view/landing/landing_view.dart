import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/horizontal_space.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/cubit/chat_cubit/chat_state.dart';
import 'package:health_tourism/cubit/clinic/clinic_cubit_state.dart';

import '../../core/components/clinic_card.dart';
import '../../core/components/ht_text.dart';
import '../../cubit/clinic/clinic_cubit.dart';
import '../../product/models/clinic.dart';
import '../../product/theme/styles.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          backgroundColor: const Color(0xff2D9CDB),
          elevation: 0,
          centerTitle: true,
          title: HTText(
            label: "VoyEsthetic",
            style: htToolBarLabel,
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffe8f3f1).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: Row(
                    children: [
                      HTIcon(
                          iconName: AssetConstants.icons.search,
                          width: 24,
                          height: 24),
                      const HorizontalSpace(),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search by Name",
                            hintStyle: htHintTextStyle,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalSpace(
              spaceAmount: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      /// TODO: Filter
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color(0xffe8f3f1), width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: Row(
                          children: [
                            HTIcon(
                                iconName: AssetConstants.icons.calendar,
                                width: 24,
                                height: 24),
                            const HorizontalSpace(),
                            HTText(label: "Filter", style: htHintTextStyle),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      /// TODO: Sort
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color(0xffe8f3f1), width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 8),
                        child: Row(
                          children: [
                            HTIcon(
                              iconName: AssetConstants.icons.sort,
                              width: 24,
                              height: 24,
                              color: const Color(0xff8fc2f3),
                            ),
                            const HorizontalSpace(),
                            HTText(label: "Sort", style: htHintTextStyle),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<ClinicCubit, ClinicState>(
                builder: (context, state) {
                  if(state is ClinicsError) {
                    return Center(
                      child: HTText(label: state.message, style: htHintTextStyle,),
                    );
                  }
                  if (state is ClinicLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ClinicsLoaded2) {
                    return Expanded(child: buildClinicList(state));
                  }
                  else {
                    return const Center(
                      child: HTText(label: 'Something went wrong!', style: htLabelBlackStyle,),
                    );
                  }
                }),
          ],
        )));
  }

  Widget buildClinicList(ClinicsLoaded2 state) {
    return StreamBuilder(
        stream: state.clinicList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  Map<dynamic, dynamic> data =
                      snapshot.data!.docs[index].data() as Map<dynamic, dynamic>;
                  final clinic = Clinic.fromData(data);

                  return ClinicCard(clinic: clinic);
                });
          }
          else {
            return const Center(
              child: HTText(label: 'Something went wrong!', style: htLabelBlackStyle,),
            );
          }
        });
  }
}
