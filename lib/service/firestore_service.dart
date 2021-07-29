import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcheque_admin/model/store_model.dart';
import 'package:fastcheque_admin/utils/database_constants.dart';
import 'package:fastcheque_admin/utils/helper_methods.dart';

class FireStoreService {
  static FireStoreService instance = FireStoreService();
  late FirebaseFirestore _firestore;
  FireStoreService() {
    _firestore = FirebaseFirestore.instance;
  }

  createStore(StoreModel model) async {
    _firestore
        .collection(DatabaseConstants.STORE_COLLECTION)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        DocumentReference document =
            _firestore.collection(DatabaseConstants.STORE_COLLECTION).doc();
        model.id = document.id;
        document.set(model.toMap()).then((value) {
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
        document
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

  updateStore(StoreModel model) async {
    DocumentReference document =
        _firestore.collection(DatabaseConstants.STORE_COLLECTION).doc(model.id);

    document.update(model.toMap()).then((value) {
      showToast('Store updated successfully');
    }).catchError((error) => showToast('Error : $error'));
  }

  deleteStore(StoreModel model) {
    DocumentReference document =
        _firestore.collection(DatabaseConstants.STORE_COLLECTION).doc(model.id);
    document
        .delete()
        .then((value) => showToast('Store deleted successfully'))
        .catchError((error) => showToast('Error : $error'));
  }

  Stream<QuerySnapshot> getStreamByCollectionName(String collection) {
    return _firestore.collection(collection).snapshots();
  }

  Stream<QuerySnapshot> getStreamByCollectionNameAndSearchString(
      String collection, String searchString) {
    return _firestore
        .collection(collection)
        .where('printerEmail', isEqualTo: searchString)
        .snapshots();
  }
}
