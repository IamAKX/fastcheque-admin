import 'package:fastcheque_admin/model/staff_model.dart';
import 'package:fastcheque_admin/screen/managers/managers_screen.dart';
import 'package:fastcheque_admin/service/firestore_service.dart';
import 'package:fastcheque_admin/utils/color.dart';
import 'package:fastcheque_admin/utils/constants.dart';
import 'package:fastcheque_admin/utils/helper_methods.dart';
import 'package:fastcheque_admin/widgets/header.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  TextEditingController _searchCtrl = TextEditingController();

  List<StaffModel> _allStaffList = [];
  List<StaffModel> _allStaffListCopy = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    loadAllStaffs();

    _searchCtrl.addListener(() async {
      if (_searchCtrl.text.isEmpty) {
        _allStaffList.clear();
        _allStaffList.addAll(_allStaffListCopy);
      } else {
        _allStaffList.removeWhere((element) => !(element.name
                .toLowerCase()
                .contains(_searchCtrl.text.toLowerCase()) ||
            element.taggedStore.businessName
                .toLowerCase()
                .contains(_searchCtrl.text.toLowerCase()) ||
            element.email
                .toLowerCase()
                .contains(_searchCtrl.text.toLowerCase())));
      }
      setState(() {});
    });
  }

  Future<void> loadAllStaffs() async {
    _allStaffList.clear();
    _allStaffListCopy.clear();
    _searchCtrl.text = '';
    FireStoreService.instance.readAllStaffs().then((list) {
      _allStaffList.addAll(list);
      _allStaffListCopy.addAll(list);
      setState(() {});
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
            Header(title: 'Staff'),
            SizedBox(
              height: defaultPadding,
            ),
            TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                fillColor: secondaryColor,
                filled: true,
                hintText: 'Search by staff name / email / store name...',
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
                    for (StaffModel staff in _allStaffList) ...{
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
                              child: Text('${staff.id}'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${staff.name}'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${staff.email}'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${staff.taggedStore.businessName}'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      showStaffDetailsPopup(staff, context);
                                    },
                                    color: Colors.blue,
                                    icon: Icon(Icons.visibility),
                                  ),
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                  Switch(
                                    value: staff.isProfileActive,
                                    onChanged: (status) async {
                                      await FireStoreService.instance
                                          .toggleStaffSuspension(staff, status)
                                          .then((value) {
                                        _allStaffList
                                            .firstWhere((element) =>
                                                element.id == staff.id)
                                            .isProfileActive = status;
                                        setState(() {});
                                      });
                                    },
                                  ),
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

  void showStaffDetailsPopup(StaffModel staff, BuildContext context) {
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
        "Staff Details",
        style: Theme.of(context).textTheme.headline5,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ManagerDetailRow(
            value: staff.name,
            name: 'Name',
          ),
          ManagerDetailRow(
            value: staff.email,
            name: 'Email',
          ),
          ManagerDetailRow(
            value: getStoreDetailOfStaff(staff),
            name: 'Tagged stores',
          ),
          ManagerDetailRow(
            value: staff.id,
            name: 'User ID',
          ),
          ManagerDetailRow(
            value: staff.uid,
            name: 'Auth ID',
          ),
          ManagerDetailRow(
            value: staff.isPasswordTemporary ? 'Yes' : 'No',
            name: 'Temporary Password',
          ),
          ManagerDetailRow(
            value: staff.isProfileActive ? 'Yes' : 'No',
            name: 'Status',
          ),
          ManagerDetailRow(
            value: staff.hasManagerApproved ? 'Yes' : 'No',
            name: 'Manager approved',
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
