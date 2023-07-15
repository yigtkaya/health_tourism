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
  const ClinicsLoaded();
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