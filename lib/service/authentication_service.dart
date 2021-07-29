import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcheque_admin/model/manager_model.dart';
import 'package:fastcheque_admin/utils/database_constants.dart';
import 'package:fastcheque_admin/utils/helper_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  static AuthenticationService instance = AuthenticationService();
  late FirebaseAuth _auth;

  AuthenticationService() {
    _auth = FirebaseAuth.instance;
  }

  Future<void> registerUserWithEmailAndPassword(
      FirebaseFirestore firestore, ManagerModel model) async {
    try {
      UserCredential _result = await _auth.createUserWithEmailAndPassword(
          email: model.email, password: model.email);
      User? user = _result.user;

      user!.updateDisplayName(model.name);
      user.sendEmailVerification();

      DocumentReference document =
          firestore.collection(DatabaseConstants.USERS_COLLECTION).doc();
      model.id = document.id;
      model.uid = user.uid;

      await document.set(model.toMap()).then((value) {
        showToast('User created successfully');
        return;
      });
    } on FirebaseAuthException catch (e) {
      showToast('Error : ${e.message}');
    }
  }
}
