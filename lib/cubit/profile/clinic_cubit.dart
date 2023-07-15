import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/cubit/profile/clinic_cubit_state.dart';
import 'package:health_tourism/product/services/firestore_service.dart';

import '../../product/models/clinics-entity.dart';

class ClinicCubit extends ClinicState {

  ClinicCubit() : super(const ClinicInitState()){
    getClinicData();
  }

}

static ClinicCubit get(context) => BlocProvider.of(context);


final FirestoreService _firestoreService = FirestoreService();



void getClinicData() {
  try {
    emit(const ClinicLoadingState());
    _firestoreService.getClinicData().then((value) {
      emit(ClinicCubit(value));
    }).catchError((e) {
      emit(const ClinicErrorState('Error while loading clinic data'));
    });
  } catch (e) {
    emit(const ClinicErrorState('Error while loading clinic data'));
  }
}

class ClinicErrorState extends ClinicState {
  final String errorMessage;

  const ClinicErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}