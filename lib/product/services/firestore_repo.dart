import '../models/user.dart';

abstract class FirestoreRepository {
  Future<Customer> getCustomer() async {
    // TODO: implement getCustomer
    throw UnimplementedError();
  }
  Future<void> updateUserData(Customer customer);
  Future<void> deleteCustomer(String uid);
  Future<void> createCustomer(
      String uid,
      String email,
      int birthday,
      String fullName,
      bool alcohol,
      bool smoke,
      String medications,
      String allergies,
      String previousOperations,
      String skinDiseases,
      String chronicConditions,
      String hairTransplantOperations);
}
