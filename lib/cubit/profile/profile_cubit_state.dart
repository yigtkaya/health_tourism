import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ProfileState {
  const ProfileState();
}

// create initial state
class ProfileInitState extends ProfileState {
  const ProfileInitState();
}

// create loading state
class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState();
}

class ProfileLoadedState extends ProfileState {
  Stream<DocumentSnapshot> userSnapshot;
  ProfileLoadedState(this.userSnapshot);
}

// create error state
class ProfileErrorState extends ProfileState {
  final String message;
  const ProfileErrorState(this.message);
}
