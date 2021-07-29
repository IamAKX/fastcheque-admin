import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcheque_admin/model/manager_model.dart';
import 'package:fastcheque_admin/model/store_model.dart';
import 'package:fastcheque_admin/service/authentication_service.dart';
import 'package:fastcheque_admin/utils/database_constants.dart';
import 'package:fastcheque_admin/utils/helper_methods.dart';

class FireStoreService {
  static FireStoreService instance = FireStoreService();
  late FirebaseFirestore _firestore;
  FireStoreService() {
    _firestore = FirebaseFirestore.instance;
  }

  Future<void> createStore(StoreModel model) async {
    await _firestore
        .collection(DatabaseConstants.STORE_COLLECTION)
        .get()
        .then((querySnapshot) async {
      if (querySnapshot.docs.isEmpty) {
        DocumentReference document =
            _firestore.collection(DatabaseConstants.STORE_COLLECTION).doc();
        model.id = document.id;
        await document.set(model.toMap()).then((value) {
          showToast('Store added successfully');
          return;
        });
      }
      bool isInvalidEntry = false;

      querySnapshot.docs.forEach((querySnapshot) {
        StoreModel store = StoreModel.fromMap(querySnapshot.data());
        if (store.printerEmail == model.printerEmail) {
          isInvalidEntry = true;
        }
        if (store.chequeSequenceNumber == model.chequeSequenceNumber) {
          isInvalidEntry = true;
        }
      });

      if (!isInvalidEntry) {
        DocumentReference document =
            _firestore.collection(DatabaseConstants.STORE_COLLECTION).doc();
        model.id = document.id;
        await document
            .set(model.toMap())
            .then((value) => showToast('Store added successfully'));
      } else
        showToast('Error : Identical buisness email or cheque sequence.');
    }).catchError((error) => showToast('Error : $error'));
  }

  Future<List<StoreModel>> readAllStore() async {
    List<StoreModel> list = [];

    await _firestore
        .collection(DatabaseConstants.STORE_COLLECTION)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((querySnapshot) {
        StoreModel store = StoreModel.fromMap(querySnapshot.data());
        list.add(store);
      });
      return list;
    }).catchError((error) => showToast('Error : $error'));
    return list;
  }

  Future<void> updateStore(StoreModel model) async {
    DocumentReference document =
        _firestore.collection(DatabaseConstants.STORE_COLLECTION).doc(model.id);

    await document.update(model.toMap()).then((value) {
      showToast('Store updated successfully');
    }).catchError((error) => showToast('Error : $error'));
  }

  Future<void> deleteStore(StoreModel model) async {
    DocumentReference document =
        _firestore.collection(DatabaseConstants.STORE_COLLECTION).doc(model.id);
    await document
        .delete()
        .then((value) => showToast('Store deleted successfully'))
        .catchError((error) => showToast('Error : $error'));
  }

  Future<void> createManager(ManagerModel model) async {
    print('model.taggedStores = ${model.toMap()}');
    if (model.taggedStores.length == 0) {
      showToast('Select atlease 1 store');
      return;
    }
    await AuthenticationService.instance
        .registerUserWithEmailAndPassword(_firestore, model);
    // await _firestore
    //     .collection(DatabaseConstants.USERS_COLLECTION)
    //     .where('email', isEqualTo: model.email)
    //     .get()
    //     .then((querySnapshot) async {
    //   if (querySnapshot.docs.isEmpty) {
    //     await AuthenticationService.instance
    //         .registerUserWithEmailAndPassword(_firestore, model);
    //   } else {
    //     showToast('User with ${model.email} is registered');
    //   }
    // }).catchError((error) => showToast('Error : $error'));
  }

  Future<List<ManagerModel>> readAllManagers() async {
    List<ManagerModel> list = [];

    await _firestore
        .collection(DatabaseConstants.USERS_COLLECTION)
        .where('userType', isEqualTo: DatabaseConstants.USERS_TYPE_MANAGER)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((querySnapshot) {
        ManagerModel store = ManagerModel.fromMap(querySnapshot.data());
        list.add(store);
      });
      return list;
    }).catchError((error) => showToast('Error : $error'));
    return list;
  }

  Future<void> toggleManagerSuspension(ManagerModel model, bool status) async {
    DocumentReference document =
        _firestore.collection(DatabaseConstants.USERS_COLLECTION).doc(model.id);

    await document.update({'isProfileActive': status}).then((value) {
      showToast('${model.name} is ${status ? 'activated' : 'deactivated'}');
    }).catchError((error) => showToast('Error : $error'));
  }

  Future<void> deleteManager(ManagerModel model) async {
    DocumentReference document =
        _firestore.collection(DatabaseConstants.USERS_COLLECTION).doc(model.id);
    await document
        .delete()
        .then((value) => showToast('Manager deleted successfully'))
        .catchError((error) => showToast('Error : $error'));
  }
}
