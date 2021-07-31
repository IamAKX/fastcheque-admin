import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcheque_admin/model/manager_model.dart';
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
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class ManagersScreen extends StatefulWidget {
  const ManagersScreen({Key? key}) : super(key: key);

  @override
  _ManagersScreenState createState() => _ManagersScreenState();
}

class _ManagersScreenState extends State<ManagersScreen> {
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _searchCtrl = TextEditingController();
  List<StoreModel> _allStoreLocally = [];

  List<StoreModel> _selectedStore = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();
  List<MultiSelectItem<StoreModel>> _dropDownList = [];
  List<ManagerModel> _allManagerList = [];
  List<ManagerModel> _allManagerListCopy = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    loadAllStore();

    loadAllManagers();

    _searchCtrl.addListener(() async {
      if (_searchCtrl.text.isEmpty) {
        _allManagerList.clear();
        _allManagerList.addAll(_allManagerListCopy);
      } else {
        _allManagerList.removeWhere((element) => !(element.name
                .toLowerCase()
                .contains(_searchCtrl.text.toLowerCase()) ||
            element.email
                .toLowerCase()
                .contains(_searchCtrl.text.toLowerCase())));
      }
      setState(() {});
    });
  }

  Future<void> loadAllManagers() async {
    _allManagerList.clear();
    _allManagerListCopy.clear();
    _searchCtrl.text = '';
    FireStoreService.instance.readAllManagers().then((list) {
      _allManagerList.addAll(list);
      _allManagerListCopy.addAll(list);
      setState(() {});
    });
  }

  Future<void> loadAllStore() async {
    FireStoreService.instance.readAllStore().then((list) {
      _allStoreLocally.addAll(list);

      _dropDownList = _allStoreLocally
          .map((store) =>
              MultiSelectItem<StoreModel>(store, store.chequeSequenceNumber))
          .toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: 'Managers'),
            SizedBox(
              height: defaultPadding,
            ),
            Text(
              'Create Manager',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: defaultPadding,
            ),
            GridView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
                  mainAxisSpacing: defaultPadding,
                  crossAxisSpacing: defaultPadding,
                  mainAxisExtent: 50,
                  childAspectRatio: 3),
              children: [
                CustomTextField(
                  nameCtrl: _nameCtrl,
                  hint: 'Name',
                ),
                CustomTextField(
                  nameCtrl: _emailCtrl,
                  hint: 'Email',
                ),
              ],
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Container(
              width: Responsive.isMobile(context)
                  ? width
                  : ((width * 5 / 6) -
                          defaultPadding -
                          defaultPadding -
                          defaultPadding) /
                      2,
              child: MultiSelectDialogField(
                key: _multiSelectKey,
                items: _dropDownList,
                height: MediaQuery.of(context).size.height * 0.75,
                itemsTextStyle: Theme.of(context).textTheme.subtitle1,
                searchable: true,
                selectedItemsTextStyle: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: primaryColor),
                title: Text('Select store'),
                buttonText: Text('Select store'),
                chipDisplay: MultiSelectChipDisplay(
                  textStyle: Theme.of(context).textTheme.subtitle2,
                ),
                backgroundColor: secondaryColor,
                cancelText: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.button,
                ),
                confirmText: Text(
                  'Done',
                  style: Theme.of(context).textTheme.button,
                ),
                initialValue: _selectedStore,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    color: Colors.white54,
                  ),
                ),
                selectedColor: primaryColor,
                unselectedColor: Colors.white,
                onSelectionChanged: (list) {
                  _selectedStore.clear();
                  list.forEach((element) {
                    _selectedStore.add(element as StoreModel);
                  });
                },
                onConfirm: (list) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            ElevatedButton(
              onPressed: () async {
                if (checkAllMandatoryFields([_nameCtrl, _emailCtrl]) &&
                    checkValidEmail(_emailCtrl.text)) {
                  ManagerModel model = ManagerModel(
                      id: '',
                      uid: '',
                      firebaseFCMToken: '',
                      name: _nameCtrl.text,
                      email: _emailCtrl.text,
                      isProfileActive: true,
                      isPasswordTemporary: true,
                      userType: DatabaseConstants.USERS_TYPE_MANAGER,
                      taggedStores: _selectedStore);

                  await FireStoreService.instance.createManager(model).then(
                        (value) => setState(() {
                          loadAllManagers();
                          _nameCtrl.text = '';
                          _emailCtrl.text = '';
                        }),
                      );
                }
              },
              child: Text('Create'),
            ),
            SizedBox(
              height: defaultPadding * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Managers',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.file_download),
                  label: Text('Download CSV'),
                ),
              ],
            ),
            SizedBox(
              height: defaultPadding,
            ),
            TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                fillColor: secondaryColor,
                filled: true,
                hintText: 'Search by name/email/store...',
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
                child: Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                    4: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: secondaryColor),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('ID'),
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
                            child: Text('Store'),
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
                    for (ManagerModel manager in _allManagerList) ...{
                      TableRow(
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
                              child: Text(manager.id),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(manager.name),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(manager.email),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  getChequeSequenceStringFromManager(manager)),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showMangerDetailsPopup(manager, context);
                                    },
                                    color: Colors.blue,
                                    icon: Icon(Icons.visibility),
                                  ),
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                  Switch(
                                    value: manager.isProfileActive,
                                    onChanged: (status) async {
                                      await FireStoreService.instance
                                          .toggleManagerSuspension(
                                              manager, status)
                                          .then((value) {
                                        _allManagerList
                                            .firstWhere((element) =>
                                                element.id == manager.id)
                                            .isProfileActive = status;
                                        setState(() {});
                                      });
                                    },
                                  ),
                                  // SizedBox(
                                  //   width: defaultPadding,
                                  // ),
                                  // IconButton(
                                  //   onPressed: () async {
                                  //     await FireStoreService.instance
                                  //         .deleteManager(manager)
                                  //         .then((value) {
                                  //       setState(() {
                                  //         loadAllManagers();
                                  //       });
                                  //     });
                                  //   },
                                  //   color: Colors.red,
                                  //   icon: Icon(Icons.person_remove_sharp),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    }
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showMangerDetailsPopup(ManagerModel manager, BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "Dismiss",
        style: Theme.of(context).textTheme.button,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Manager Details",
        style: Theme.of(context).textTheme.headline5,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ManagerDetailRow(
            value: manager.name,
            name: 'Name',
          ),
          ManagerDetailRow(
            value: manager.email,
            name: 'Email',
          ),
          ManagerDetailRow(
            value: getStoreDetailOfManager(manager),
            name: 'Tagged stores',
          ),
          ManagerDetailRow(
            value: manager.id,
            name: 'User ID',
          ),
          ManagerDetailRow(
            value: manager.uid,
            name: 'Auth ID',
          ),
          ManagerDetailRow(
            value: manager.isPasswordTemporary ? 'Yes' : 'No',
            name: 'Temporary Password',
          ),
          ManagerDetailRow(
            value: manager.isProfileActive ? 'Yes' : 'No',
            name: 'Status',
          ),
        ],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return alert;
      },
    );
  }
}

class ManagerDetailRow extends StatelessWidget {
  final String name;
  final String value;
  const ManagerDetailRow({
    Key? key,
    required this.name,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              name,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          SizedBox(
            width: defaultPadding * 3,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ],
      ),
    );
  }
}
