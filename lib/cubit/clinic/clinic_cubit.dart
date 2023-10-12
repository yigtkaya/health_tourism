import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/cubit/clinic/clinic_cubit_state.dart';
import 'package:health_tourism/product/repoImpl/clinic_repo_impl.dart';
import '../../product/models/clinic.dart';

class ClinicCubit extends Cubit<ClinicState> {
  final ClinicRepositoryImpl _clinicRepositoryImpl = ClinicRepositoryImpl();
  late var clinicList = List<Clinic>;

  ClinicCubit() : super(const ClinicInitState()) {
    getClinics(false, 0.0, 5.0, "", "");
  }

  void getClinics(bool isDescending, double min, double max, String city, String searchKey) {
    emit(const ClinicLoadingState());
    Future.value(_clinicRepositoryImpl.getAllClinics(isDescending, min, max, city, searchKey))
        .then((value) {
      emit(ClinicsLoaded(value));
    }).onError((error, stackTrace) {
      emit(ClinicsError(error.toString()));
    });
  }
}
