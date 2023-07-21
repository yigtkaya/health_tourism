import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/core/app/appTheme.dart';
import 'package:health_tourism/cubit/clinic/clinic_cubit.dart';
import 'package:health_tourism/product/models/clinic.dart';

import '../../../cubit/clinic/clinic_cubit_state.dart';


class filterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicCubit, ClinicState>(
      builder: (context, state) {
        if (state is ClinicLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ClinicsLoaded) {
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
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: <Widget>[
                                const Text(
                                  "S.of(context).filter",
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

List<Clinic> filterClinics(
    List<Clinic> clinicList,
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


class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  ClinicState currentState = ClinicInitState();


  @override
  Widget build(BuildContext context) {
    return filterBar();
  }


  Future<void> updateUI(ClinicsLoaded state) async {
    setState(() {
      currentState = ClinicLoadingState();
    });

    try {
      final List<Clinic> filteredList = filterClinics(state.clinicList, 2000.0, 1000.0, 3.4);

      setState(() {
        currentState = ClinicsLoaded(filteredList);
      });
    } catch (error) {
      setState(() {
        currentState = ClinicsError(error.toString());
      });
    }
  }
}
