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
        .where('email', isEqualTo: model.printerEmail)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        showToast('Store with email ${model.printerEmail} is already present');
      } else {
        DocumentReference document =
            _firestore.collection(DatabaseConstants.STORE_COLLECTION).doc();
        model.id = document.id;
        document
            .set(model.toMap())
            .then((value) => showToast('Store added successfully'))
            .catchError((error) => showToast('Error : $error'));
      }
    });
  }

  updateStore(StoreModel model) async {
    _firestore
        .collection(DatabaseConstants.STORE_COLLECTION)
        .where('email', isEqualTo: model.printerEmail)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        showToast('Store with email ${model.printerEmail} is already present');
      } else {
        DocumentReference document = _firestore
            .collection(DatabaseConstants.STORE_COLLECTION)
            .doc(model.id);

        document
            .update(model.toMap())
            .then((value) => showToast('Store updated successfully'))
            .catchError((error) => showToast('Error : $error'));
      }
    });
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
}
