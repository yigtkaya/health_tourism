import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/core/app/appTheme.dart';
import 'package:health_tourism/cubit/profile/clinic_cubit.dart';
import 'package:health_tourism/product/models/clinic.dart';

import '../../../cubit/profile/clinic_cubit_state.dart';


class filterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicCubit, ClinicState>(
      builder: (context, state) {
        if (state is ClinicLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ClinicsLoaded) {
          final clinicList = state.clinicList;

          return Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppTheme.getTheme().backgroundColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppTheme.getTheme().dividerColor,
                        offset: const Offset(0, -2),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: AppTheme.getTheme().backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 4),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "530 clinics found",
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.grey.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                          onTap: () {
                            showFilteredClinics(
                              context,
                              clinicList,
                              1000, // Replace maxPrice with the actual value you want to use
                              100, // Replace minPrice with the actual value you want to use
                              2.0, // Replace minRating with the actual value you want to use
                            );                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: <Widget>[
                                const Text(
                                  "Filter",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.sort,
                                    color: AppTheme.getTheme().primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Divider(
                  height: 1,
                ),
              )
            ],
          );
        }
        if (state is ClinicsFiltered) {
          final clinicList = state.clinics;

          return Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppTheme.getTheme().backgroundColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppTheme.getTheme().dividerColor,
                        offset: const Offset(0, -2),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: AppTheme.getTheme().backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 4),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "530 clinics found",
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.grey.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                          onTap: () {
                            showFilteredClinics(
                              context,
                              clinicList,
                              1000, // Replace maxPrice with the actual value you want to use
                              100, // Replace minPrice with the actual value you want to use
                              2.0, // Replace minRating with the actual value you want to use
                            );                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: <Widget>[
                                const Text(
                                  "Filter",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.sort,
                                    color: AppTheme.getTheme().primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Divider(
                  height: 1,
                ),
              )
            ],
          );
        }
        if (state is ClinicsError) {
          return const Center(child: Text("HATA"));
        } else {
          return const Center(child: Text("boş"));
        }
      },
    );
  }




}


void showFilteredClinics(BuildContext context, List<ClinicEntity> clinicList,
    double maxPrice, double minPrice, double minRating) {
  final filteredClinics = filterClinics(clinicList, maxPrice, minPrice, minRating);
  context.read<ClinicCubit>().emitFilteredClinics(filteredClinics);
}


List<ClinicEntity> filterClinics(
    List<ClinicEntity> clinicList,
    double maxPrice,
    double minPrice,
    double minRating,
    ) {
  return clinicList.where((clinic) {
    final meetsPriceCondition =
        clinic.price >= minPrice && clinic.price <= maxPrice;
    final meetsRatingCondition = clinic.rating >= minRating;
    return meetsPriceCondition && meetsRatingCondition;
  }).toList();
}


