import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/cubit/clinic/clinic_cubit_state.dart';
import 'package:health_tourism/product/repoImpl/clinic_repo_impl.dart';

import '../../product/models/clinic.dart';

class ClinicCubit extends Cubit<ClinicState> {
  final ClinicRepositoryImpl _clinicRepositoryImpl = ClinicRepositoryImpl();
  late var clinicList = List<Clinic>;

  ClinicCubit() : super(const ClinicInitState()) {
    getClinics();
  }

  void getClinics() {
    emit(const ClinicLoadingState());
    Future.value(_clinicRepositoryImpl.getAllClinics())
        .then((value) => emit(ClinicsLoaded2(value)))
        .onError((error, stackTrace) => emit(ClinicsError(error.toString())));
  }
}
