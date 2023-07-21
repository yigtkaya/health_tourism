import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/cubit/profile/clinic_cubit_state.dart';
import 'package:health_tourism/product/services/firestore_service.dart';

import '../../product/models/clinic.dart';

class ClinicCubit extends Cubit<ClinicState> {
  final FirestoreService _firestoreService = FirestoreService();
  late var clinicList = List<ClinicEntity>;

  ClinicCubit() : super(const ClinicInitState()) {
    getAllClinic();
  }

  void emitFilteredClinics(List<ClinicEntity> filteredClinics) {
    emit(ClinicsFiltered(filteredClinics));
  }

  void getAllClinic() async {
    try {
      emit(const ClinicLoadingState());
      print("ClinicLoadingState");
      Future.value(_firestoreService.getClinicData())
          .then((value) => emit(ClinicsLoaded(value)));

    } catch (e) {
      emit(ClinicsError(e.toString()));
    }
  }
}


class ClinicsFiltered extends ClinicState {
  final List<ClinicEntity> clinics;

  ClinicsFiltered(this.clinics);

  @override
  List<Object?> get props => [clinics];
}
