import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_tourism/cubit/profile/clinic_cubit.dart';
import 'package:health_tourism/cubit/profile/clinic_cubit_state.dart';
import 'package:health_tourism/product/models/clinic.dart';
import 'package:health_tourism/view/clinics/operation_list_page.dart';
import 'package:health_tourism/view/clinics/widgets/calender_popup_widget.dart';
import 'package:health_tourism/view/clinics/widgets/clinic_filter_bar.dart';
import 'package:health_tourism/view/clinics/widgets/clinic_map_view_row_widget.dart';
import 'package:health_tourism/view/clinics/widgets/clinic_range_selection_widget.dart';
import 'package:health_tourism/view/clinics/widgets/clinic_row_one_widget.dart';
import 'package:intl/intl.dart';

import '../../core/app/appTheme.dart';

class ClinicsView extends StatefulWidget {
  const ClinicsView({Key? key}) : super(key: key);

  @override
  _ClinicsViewState createState() => _ClinicsViewState();
}

class _ClinicsViewState extends State<ClinicsView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  late AnimationController _animationController;
  ScrollController scrollController = ScrollController();
  List<String> operationFilter = [];
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  bool isMap = false;

  final searchBarHeight = 158.0;
  final filterBarHeight = 52.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 0), vsync: this);
    scrollController.addListener(() {
      if (scrollController.offset <= 0) {
        _animationController.animateTo(0.0);
      } else if (scrollController.offset > 0.0 &&
          scrollController.offset < searchBarHeight) {
        // we need around searchBarHieght scrolling values in 0.0 to 1.0
        _animationController
            .animateTo((scrollController.offset / searchBarHeight));
      } else {
        _animationController.animateTo(1.0);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicCubit, ClinicState>(
        builder: (context, state) {
          if( state is ClinicLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ClinicsLoaded) {
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Column(
                      children: <Widget>[
                        getAppBarUI(),
                        isMap
                            ? Expanded(
                          child: Column(
                            children: <Widget>[
                              getSearchBarUI(),
                              getTimeDateUI(),
                              Expanded(
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width,
                                      child: Image.asset(
                                        "assets/images/mapImage.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppTheme.getTheme()
                                                .scaffoldBackgroundColor
                                                .withOpacity(1.0),
                                            AppTheme.getTheme()
                                                .scaffoldBackgroundColor
                                                .withOpacity(0.0),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ),
                                  ] +
                                      getMapPinUI(state) +
                                      [
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          left: 0,
                                          child: Container(
                                            height: 156,
                                            // color: Colors.green,
                                            child: ListView.builder(
                                              itemCount: state.clinicList.length,
                                              padding: const EdgeInsets.only(
                                                  top: 8, bottom: 8, right: 16),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return ClinicMapViewRowWidget(
                                                  callback: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            OperationListPage(
                                                              clinicName:
                                                              state.clinicList[index]
                                                                  .titleTxt,
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                  clinicData: state.clinicList[index],
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                ),
                              )
                            ],
                          ),
                        )
                            : Expanded(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                color: AppTheme.getTheme().backgroundColor,
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: state.clinicList.length,
                                  padding: const EdgeInsets.only(
                                    top: 8 + 158 + 52.0,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    var count = state.clinicList.length > 10
                                        ? 10
                                        : state.clinicList.length;
                                    var animation = Tween(begin: 0.0, end: 1.0)
                                        .animate(CurvedAnimation(
                                        parent: animationController!,
                                        curve: Interval(
                                            (1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn)));
                                    animationController!.forward();
                                    return ClinicRowOneWidget(
                                      callback: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OperationListPage(
                                                  clinicName:
                                                  state.clinicList[index].titleTxt,
                                                ),
                                          ),
                                        );
                                      },
                                      clinicData: state.clinicList[index],
                                      animation: animation,
                                      animationController: animationController,
                                    );
                                  },
                                ),
                              ),
                              AnimatedBuilder(
                                animation: _animationController,
                                builder: (BuildContext context, Widget? child) {
                                  return Positioned(
                                    top: -searchBarHeight *
                                        (_animationController.value),
                                    left: 0,
                                    right: 0,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          color: AppTheme.getTheme()
                                              .scaffoldBackgroundColor,
                                          child: Column(
                                            children: <Widget>[
                                              getSearchBarUI(),
                                              getTimeDateUI(),
                                            ],
                                          ),
                                        ),
                                        filterBar(),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is ClinicsError) {
            return const Center(child:Text("HATA"));
          }
          else {
            return const Center(child:Text("boş"));
          }
        });
  }

  List<Widget> getMapPinUI(ClinicsLoaded state) {
    List<Widget> list = [];

    for (var i = 0; i < state.clinicList.length; i++) {
      double? top;
      double? left;
      double? right;
      double? bottom;
      if (i == 0) {
        top = 150;
        left = 50;
      } else if (i == 1) {
        top = 50;
        right = 50;
      } else if (i == 2) {
        top = 40;
        left = 10;
      } else if (i == 3) {
        bottom = 260;
        right = 140;
      } else if (i == 4) {
        bottom = 160;
        right = 20;
      }
      list.add(
        Positioned(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppTheme.getTheme().dividerColor,
                  blurRadius: 16,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  child: Text(
                    "\$${state.clinicList[i].price}",
                    style: TextStyle(
                        color: AppTheme.getTheme().primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  Widget getListUI(ClinicsLoaded state) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppTheme.getTheme().dividerColor,
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: state.clinicList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var count =
                      state.clinicList.length > 10 ? 10 : state.clinicList.length;
                      var animation = Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                      animationController!.forward();
                      return ClinicRowOneWidget(
                        callback: () {},
                        clinicData: state.clinicList[index],
                        animation: animation,
                        animationController: animationController,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getClinicViewList(ClinicsLoaded state) {
    List<Widget> clinicListViews = [];
    for (var i = 0; i < state.clinicList.length; i++) {
      var count = state.clinicList.length;
      var animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      clinicListViews.add(
        ClinicRowOneWidget(
          callback: () {},
          clinicData: state.clinicList[i],
          animation: animation,
          animationController: animationController,
        ),
      );
    }
    animationController!.forward();
    return Column(
      children: clinicListViews,
    );
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    // setState(() {
                    //   isDatePopupOpen = true;
                    // });
                    showDemoDialog(context: context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 4, bottom: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "S.of(context).chooseDate",
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                              color: Colors.grey.withOpacity(0.8)),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          ClinicRangeSelectionWidget(
                        operationFilter: operationFilter,
                        barrierDismissible: true,
                        onChange: (o) {
                          setState(() {
                            operationFilter.add(o);
                          });
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 4, bottom: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Operations",
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "- $operationFilter Adults",
                          style: const TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.getTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.getTheme().dividerColor,
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // Navigator.push(
                      //   context,
                      //   // MaterialPageRoute(
                      //   //     builder: (context) => SearchPage(),
                      //   //     fullscreenDialog: true),
                      // );
                    },
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: AppTheme.getTheme().primaryColor,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "S.of(context).london",
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.getTheme().primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppTheme.getTheme().dividerColor,
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  // FocusScope.of(context).requestFocus(FocusNode());
                  // Navigator.push(
                  //   context,
                  // //   MaterialPageRoute(
                  // //       // builder: (context) => SearchPage(),
                  // //       fullscreenDialog: true),
                  // // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 20, color: AppTheme.getTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  void showDemoDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CalendarPopupWidget(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime? startData, DateTime? endData) {
          setState(() {
            if (startData != null && endData != null) {
              startDate = startData;
              endDate = endData;
            }
          });
        },
        onCancelClick: () {},
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppTheme.getTheme().dividerColor,
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  "S.of(context).explore",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.favorite_border),
                    ),
                  ),
                  InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {
                      setState(() {
                        isMap = !isMap;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                          isMap ? Icons.sort : FontAwesomeIcons.mapMarkedAlt),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
