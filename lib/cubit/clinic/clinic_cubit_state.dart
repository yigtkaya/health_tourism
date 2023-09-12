import 'package:cloud_firestore/cloud_firestore.dart';

import '../../product/models/clinic.dart';

abstract class ClinicState{
  const ClinicState();

}

class ClinicInitState extends ClinicState{
  const ClinicInitState();
}

class ClinicLoadingState extends ClinicState{
  const ClinicLoadingState();
}

class ClinicsLoaded extends ClinicState {
  final Stream<QuerySnapshot> clinicList;
  const ClinicsLoaded(this.clinicList);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClinicsLoaded && other.clinicList == clinicList;
  }

  @override
  int get hashCode => clinicList.hashCode;
}

class ClinicsError extends ClinicState {
  final String message;
  const ClinicsError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClinicsError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}