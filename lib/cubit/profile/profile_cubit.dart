
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/cubit/profile/profile_cubit_state.dart';
import 'package:health_tourism/product/services/firestore_service.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitState()) {
    getUserData();
  }

  static ProfileCubit get(context) => BlocProvider.of(context);

  final FirestoreService _firestoreService = FirestoreService();

  // create function read user data from firestore
  void getUserData() {
    try {
      emit(const ProfileLoadingState());
      Future.value(_firestoreService.getCustomer()
      ).then((value) => {
        emit(ProfileLoadedState(value))
      });
    } on Exception catch (e) {
      emit(const ProfileErrorState('Error while loading user data'));
    }
    // if error

  }

}