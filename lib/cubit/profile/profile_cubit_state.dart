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

// create loaded state
class ProfileLoadedState extends ProfileState {
  const ProfileLoadedState();
}

// create error state
class ProfileErrorState extends ProfileState {
  final String message;
  const ProfileErrorState(this.message);
}
