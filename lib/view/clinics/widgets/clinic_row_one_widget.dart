import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_tourism/core/app/appTheme.dart';
import 'package:health_tourism/product/models/clinic.dart';
import 'package:health_tourism/view/clinics/widgets/rating_bar_widget.dart';


class ClinicRowOneWidget extends StatelessWidget {
  const ClinicRowOneWidget(
      {Key? key,
        this.isShowDate= false,
        this.callback,
        this.clinicData,
        this.animationController,
        this.animation})
      : super(key: key);
  final bool isShowDate;
  final VoidCallback? callback;
  final Clinic? clinicData;
  final AnimationController? animationController;
  final Animation? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation as Animation<double>,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: Column(
                children: <Widget>[
                  isShowDate
                      ? Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Text(clinicData!.dateTxt +
                        ', ' +
                        "clinicData!.roomSizeTxt"),
                  )
                      : const SizedBox(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppTheme.getTheme().dividerColor,
                          offset: const Offset(4, 4),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 2,
                                child: Image.asset(
                                  clinicData!.operationPhotosPath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: AppTheme.getTheme().backgroundColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 8, bottom: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                clinicData!.titleTxt,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    clinicData!.subTxt,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey
                                                            .withOpacity(0.8)),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .mapMarkerAlt,
                                                    size: 12,
                                                    color: AppTheme.getTheme()
                                                        .primaryColor,
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Row(
                                                  children: <Widget>[
                                                    RatingBarWidget(
                                                      rating: clinicData!.rating,
                                                      size: 20,
                                                      activeColor: AppTheme.getTheme()
                                                          .primaryColor,
                                                    ),
                                                    Text(
                                                      " ${clinicData!.reviews} Reviews",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey
                                                              .withOpacity(
                                                              0.8)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 16, top: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "\$${clinicData!.price}",
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Text(
                                            "S.of(context).perNight",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey
                                                    .withOpacity(0.8)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            bottom: 0,
                            left: 0,
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: AppTheme.getTheme()
                                  .primaryColor
                                  .withOpacity(0.1),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              onTap: () {
                                try {
                                  callback!();
                                } catch (e) {}
                              },
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppTheme.getTheme().backgroundColor,
                                  shape: BoxShape.circle),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: AppTheme.getTheme().primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}