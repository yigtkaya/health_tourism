
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/cubit/profile/profile_cubit_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  FirestoreService _firestoreService = FirestoreService();

  // create function read user data from firestore
  void getUserData() {
    emit(const ProfileLoadingState());

    emit(const ProfileLoadedState());
    // if error
    emit(const ProfileErrorState('Error while loading user data'));
  }

}