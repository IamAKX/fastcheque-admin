import 'dart:developer';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcheque_admin/model/store_model.dart';
import 'package:fastcheque_admin/service/firestore_service.dart';
import 'package:fastcheque_admin/utils/color.dart';
import 'package:fastcheque_admin/utils/constants.dart';
import 'package:fastcheque_admin/utils/database_constants.dart';
import 'package:fastcheque_admin/utils/helper_methods.dart';
import 'package:fastcheque_admin/utils/validation.dart';
import 'package:fastcheque_admin/widgets/custom_text_field.dart';
import 'package:fastcheque_admin/widgets/header.dart';
import 'package:fastcheque_admin/widgets/responsive.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:sn_progress_dialog/progress_dialog.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  TextEditingController _chequeSequenceCtrl = TextEditingController();
  TextEditingController _printerEmailCtrl = TextEditingController();
  TextEditingController _businessEmailCtrl = TextEditingController();
  TextEditingController _routingAccNumberCtrl = TextEditingController();
  TextEditingController _bankAccNumberCtrl = TextEditingController();
  TextEditingController _bankNameCtrl = TextEditingController();
  TextEditingController _businessNameCtrl = TextEditingController();
  TextEditingController _businessAddressCtrl = TextEditingController();
  TextEditingController _businessPhoneCtrl = TextEditingController();

  TextEditingController _searchCtrl = TextEditingController();
  Stream<QuerySnapshot> _storeStream = FireStoreService.instance
      .getStreamByCollectionName(DatabaseConstants.STORE_COLLECTION);

  bool _isUpdateFormActive = false;
  String _currentEditedStoreID = '';
  String _bankLogoLink = '';
  String _businessLogoLink = '';

  final int UPLOAD_BANK_LOGO = 1;
  final int UPLOAD_BUSINESS_LOGO = 2;

  selectImageFile(int uploadType) async {
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen(
      (changeEvent) {
        final file = uploadInput.files!.first;
        final reader = FileReader();

        reader.readAsDataUrl(file);

        reader.onLoadEnd.listen(
          // After file finiesh reading and loading, it will be uploaded to firebase storage
          (loadEndEvent) async {
            uploadToFirebaseStorage(file, uploadType);
          },
        );
      },
    );
  }

  uploadToFirebaseStorage(File imageFile, int uploadType) async {
    final filePath = 'STORE/${DateTime.now()}_${imageFile.name}';
    fb.UploadTask _uploadTask = fb
        .storage()
        .refFromURL('gs://fastcheque-eadf9.appspot.com')
        .child(filePath)
        .put(imageFile);

    ProgressDialog pr = ProgressDialog(context: context);

    pr.show(
        max: 100,
        msg: 'Uploading...',
        borderRadius: 2,
        elevation: 10,
        backgroundColor: secondaryColor,
        msgColor: Colors.white,
        barrierDismissible: false);

    await _uploadTask.future.then((UploadTaskSnapshot snapshot) {
      Future.delayed(Duration(seconds: 1)).then((value) {
        pr.close();
        snapshot.ref.getDownloadURL().then((dynamic uri) {
          // uri is the link to the uploaded file
          setState(() {
            print('Uploaded link : ${uri.toString()}');
            if (uploadType == UPLOAD_BANK_LOGO)
              _bankLogoLink = uri.toString();
            else
              _businessLogoLink = uri.toString();
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: 'Store'),
            SizedBox(
              height: defaultPadding,
            ),
            Text(
              'Create Store',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: defaultPadding,
            ),
            GridView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
                  mainAxisSpacing: defaultPadding,
                  crossAxisSpacing: defaultPadding,
                  mainAxisExtent: 50,
                  childAspectRatio: 3),
              children: [
                CustomTextField(
                  nameCtrl: _chequeSequenceCtrl,
                  hint: 'Cheque Sequence (3 Char)',
                ),
                CustomTextField(
                  nameCtrl: _printerEmailCtrl,
                  hint: '* Printer Email',
                ),
                CustomTextField(
                  nameCtrl: _businessEmailCtrl,
                  hint: 'Business Email',
                ),
                CustomTextField(
                  nameCtrl: _businessNameCtrl,
                  hint: 'Business Name',
                ),
                CustomTextField(
                  nameCtrl: _businessAddressCtrl,
                  hint: 'Business Address',
                ),
                CustomTextField(
                  nameCtrl: _businessPhoneCtrl,
                  hint: 'Business Phone',
                ),
                CustomTextField(
                  nameCtrl: _routingAccNumberCtrl,
                  hint: 'Routing Account number',
                ),
                CustomTextField(
                  nameCtrl: _bankAccNumberCtrl,
                  hint: 'Bank Account Number',
                ),
                CustomTextField(
                  nameCtrl: _bankNameCtrl,
                  hint: 'Bank Name',
                ),
                if (Responsive.isDesktop(context)) ...{
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => selectImageFile(UPLOAD_BANK_LOGO),
                          onDoubleTap: () => print('double tap'),
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _bankLogoLink.isEmpty
                                  ? secondaryColor
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: Colors.green),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(_bankLogoLink.isEmpty
                                    ? Icons.upload
                                    : Icons.check_circle_outline),
                                SizedBox(
                                  width: defaultPadding / 2,
                                ),
                                Text('Bank Logo'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => selectImageFile(UPLOAD_BUSINESS_LOGO),
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _businessLogoLink.isEmpty
                                  ? secondaryColor
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: Colors.green),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(_businessLogoLink.isEmpty
                                    ? Icons.upload
                                    : Icons.check_circle_outline),
                                SizedBox(
                                  width: defaultPadding / 2,
                                ),
                                Text('Business Logo'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                } else ...{
                  InkWell(
                    onTap: () => selectImageFile(UPLOAD_BANK_LOGO),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _bankLogoLink.isEmpty
                            ? secondaryColor
                            : Colors.green,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_bankLogoLink.isEmpty
                              ? Icons.upload
                              : Icons.check_circle_outline),
                          SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Text('Bank Logo'),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => selectImageFile(UPLOAD_BUSINESS_LOGO),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _businessLogoLink.isEmpty
                            ? secondaryColor
                            : Colors.green,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_businessLogoLink.isEmpty
                              ? Icons.upload
                              : Icons.check_circle_outline),
                          SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Text('Business Logo'),
                        ],
                      ),
                    ),
                  )
                }
              ],
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (checkAllMandatoryFields([
                          _printerEmailCtrl,
                          _chequeSequenceCtrl,
                          _routingAccNumberCtrl,
                          _bankAccNumberCtrl,
                          _bankNameCtrl,
                          _businessNameCtrl,
                          _businessAddressCtrl,
                          _businessPhoneCtrl,
                          _businessEmailCtrl,
                        ]) &&
                        checkAllEmptyString(
                            [_bankLogoLink, _businessLogoLink]) &&
                        checkValidEmail(_printerEmailCtrl.text)) {
                      FireStoreService.instance.createStore(
                        StoreModel(
                          id: '',
                          chequeSequenceNumber: _chequeSequenceCtrl.text,
                          printerEmail: _printerEmailCtrl.text,
                          routingAccountNumber: _routingAccNumberCtrl.text,
                          bankAccountNumber: _bankAccNumberCtrl.text,
                          bankName: _bankNameCtrl.text,
                          businessName: _businessNameCtrl.text,
                          businessAddress: _businessAddressCtrl.text,
                          businessPhone: _businessPhoneCtrl.text,
                          bankLogoUrl: '',
                          businessLogoUrl: '',
                          businessEmail: _businessEmailCtrl.text,
                        ),
                      );
                      _chequeSequenceCtrl.text = '';
                      _printerEmailCtrl.text = '';
                      _routingAccNumberCtrl.text = '';
                      _bankAccNumberCtrl.text = '';
                      _bankNameCtrl.text = '';
                      _businessNameCtrl.text = '';
                      _businessAddressCtrl.text = '';
                      _businessPhoneCtrl.text = '';
                      _businessEmailCtrl.text = '';
                      _bankLogoLink = '';
                      _businessLogoLink = '';
                      setState(() {});
                    }
                  },
                  child: Text('Create'),
                ),
                SizedBox(
                  width: defaultPadding,
                ),
                if (_isUpdateFormActive)
                  ElevatedButton(
                    onPressed: () {
                      if (checkAllMandatoryFields([
                            _printerEmailCtrl,
                            _chequeSequenceCtrl,
                            _routingAccNumberCtrl,
                            _bankAccNumberCtrl,
                            _bankNameCtrl,
                            _businessNameCtrl,
                            _businessAddressCtrl,
                            _businessPhoneCtrl,
                          ]) &&
                          checkAllEmptyString([
                            _bankLogoLink,
                            _businessLogoLink,
                            _currentEditedStoreID
                          ]) &&
                          checkValidEmail(_printerEmailCtrl.text)) {
                        FireStoreService.instance.updateStore(
                          StoreModel(
                            id: _currentEditedStoreID,
                            chequeSequenceNumber: _chequeSequenceCtrl.text,
                            printerEmail: _printerEmailCtrl.text,
                            routingAccountNumber: _routingAccNumberCtrl.text,
                            bankAccountNumber: _bankAccNumberCtrl.text,
                            bankName: _bankNameCtrl.text,
                            businessName: _businessNameCtrl.text,
                            businessAddress: _businessAddressCtrl.text,
                            businessPhone: _businessPhoneCtrl.text,
                            bankLogoUrl: '',
                            businessLogoUrl: '',
                            businessEmail: _businessEmailCtrl.text,
                          ),
                        );
                        _currentEditedStoreID = '';
                        _chequeSequenceCtrl.text = '';
                        _printerEmailCtrl.text = '';
                        _routingAccNumberCtrl.text = '';
                        _bankAccNumberCtrl.text = '';
                        _bankNameCtrl.text = '';
                        _businessNameCtrl.text = '';
                        _businessAddressCtrl.text = '';
                        _businessPhoneCtrl.text = '';
                        _businessEmailCtrl.text = '';
                        _bankLogoLink = '';
                        _businessLogoLink = '';
                        setState(() {
                          _isUpdateFormActive = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrangeAccent),
                    child: Text('Update'),
                  ),
              ],
            ),
            SizedBox(
              height: defaultPadding * 2,
            ),
            Text(
              'All Stores',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                fillColor: secondaryColor,
                filled: true,
                hintText: 'Search by name/email...',
                prefixIcon: Icon(Icons.search),
                labelStyle: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 1150,
                alignment: Alignment.center,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _storeStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Something went wrong'),
                      );
                    }
                    return Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FlexColumnWidth(),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth(),
                        3: FlexColumnWidth(),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: secondaryColor),
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Store ID'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Name'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Email'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Actions'),
                              ),
                            ),
                          ],
                        ),
                        ...snapshot.data!.docs.map((queryDocumentSnapshot) {
                          StoreModel store = StoreModel.fromMap(
                              queryDocumentSnapshot.data()
                                  as Map<String, dynamic>);
                          return TableRow(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.white10),
                              ),
                            ),
                            // decoration: BoxDecoration(color: secondaryColor),
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${store.id}'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${store.chequeSequenceNumber}'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${store.printerEmail}'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _printerEmailCtrl.text =
                                              store.printerEmail;
                                          _chequeSequenceCtrl.text =
                                              store.chequeSequenceNumber;
                                          _routingAccNumberCtrl.text =
                                              store.routingAccountNumber;
                                          _bankAccNumberCtrl.text =
                                              store.bankAccountNumber;
                                          _bankNameCtrl.text = store.bankName;
                                          _businessNameCtrl.text =
                                              store.businessName;
                                          _businessAddressCtrl.text =
                                              store.businessAddress;
                                          _businessPhoneCtrl.text =
                                              store.businessPhone;
                                        },
                                        color: Colors.green,
                                        icon: Icon(Icons.visibility),
                                      ),
                                      SizedBox(
                                        width: defaultPadding,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _currentEditedStoreID = store.id;
                                            _isUpdateFormActive =
                                                !_isUpdateFormActive;
                                            if (_isUpdateFormActive) {
                                              _printerEmailCtrl.text =
                                                  store.printerEmail;
                                              _chequeSequenceCtrl.text =
                                                  store.chequeSequenceNumber;
                                              _routingAccNumberCtrl.text =
                                                  store.routingAccountNumber;
                                              _bankAccNumberCtrl.text =
                                                  store.bankAccountNumber;
                                              _bankNameCtrl.text =
                                                  store.bankName;
                                              _businessNameCtrl.text =
                                                  store.businessName;
                                              _businessAddressCtrl.text =
                                                  store.businessAddress;
                                              _businessPhoneCtrl.text =
                                                  store.businessPhone;
                                            } else {
                                              _chequeSequenceCtrl.text = '';
                                              _printerEmailCtrl.text = '';
                                              _routingAccNumberCtrl.text = '';
                                              _bankAccNumberCtrl.text = '';
                                              _bankNameCtrl.text = '';
                                              _businessNameCtrl.text = '';
                                              _businessAddressCtrl.text = '';
                                              _businessPhoneCtrl.text = '';
                                              _businessEmailCtrl.text = '';
                                              _bankLogoLink = '';
                                              _businessLogoLink = '';
                                            }
                                          });
                                        },
                                        color: Colors.blue,
                                        icon: Icon(Icons.edit),
                                      ),
                                      SizedBox(
                                        width: defaultPadding,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          FireStoreService.instance
                                              .deleteStore(store);
                                        },
                                        color: Colors.red,
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
