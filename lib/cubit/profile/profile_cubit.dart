import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/cubit/profile/profile_cubit_state.dart';
import 'package:health_tourism/product/repoImpl/user_%20repo_impl.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final firebaseAuth = FirebaseAuth.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  ProfileCubit() : super(const ProfileInitState()) {
    getUserSnapshot(uid);
  }

  static ProfileCubit get(context) => BlocProvider.of(context);

  final UserRepositoryImpl _userRepositoryImpl = UserRepositoryImpl();

  void getUserSnapshot(String uid) {
    try {
      emit(const ProfileLoadingState());
      Future.value(_userRepositoryImpl.getUserSnapshot(uid)
      ).then((value) => {
        emit(ProfileLoaded2State(value))
      });
    } on Exception catch (e) {
      emit(const ProfileErrorState('Error while loading user data'));
    }
    // if error

  }
}