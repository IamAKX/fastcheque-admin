import 'package:dropdown_below/dropdown_below.dart';
import 'package:fastcheque_admin/model/store_model.dart';
import 'package:fastcheque_admin/utils/color.dart';
import 'package:fastcheque_admin/utils/constants.dart';
import 'package:fastcheque_admin/utils/static_data.dart';
import 'package:fastcheque_admin/widgets/custom_text_field.dart';
import 'package:fastcheque_admin/widgets/header.dart';
import 'package:fastcheque_admin/widgets/responsive.dart';
import 'package:flutter/material.dart';

class ManagersScreen extends StatefulWidget {
  const ManagersScreen({Key? key}) : super(key: key);

  @override
  _ManagersScreenState createState() => _ManagersScreenState();
}

class _ManagersScreenState extends State<ManagersScreen> {
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _searchCtrl = TextEditingController();
  StoreModel _selectedStore = STORE_LIST.first;

  List<DropdownMenuItem> _dropdownStoreItems = [];

  @override
  void initState() {
    // TODO: implement initState
    _dropdownStoreItems = buildDropdownTestItems(STORE_LIST);
    super.initState();
  }

  List<DropdownMenuItem> buildDropdownTestItems(List<StoreModel> _testList) {
    List<DropdownMenuItem> items = [];
    for (StoreModel m in _testList) {
      items.add(
        DropdownMenuItem(
          value: m,
          child: Text(
            m.name,
            style: TextStyle(color: secondaryColor),
          ),
        ),
      );
    }
    return items;
  }

  onChangeDropdownTests(selectedStore) {
    print(selectedStore);
    setState(() {
      _selectedStore = selectedStore;
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
                DropdownBelow(
                  itemWidth: 600,
                  itemTextstyle: TextStyle(color: Colors.white),
                  boxTextstyle: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(color: Colors.white),
                  boxPadding: EdgeInsets.fromLTRB(13, 12, 0, 12),
                  boxHeight: 50,
                  boxWidth: 600,
                  icon: Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                  style: TextStyle(color: Colors.white),
                  boxDecoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: Colors.white54),
                  ),
                  hint: Text(
                    'Select Store',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: _selectedStore,
                  items: _dropdownStoreItems,
                  onChanged: onChangeDropdownTests,
                ),
              ],
            ),
            SizedBox(
              height: defaultPadding,
            ),
            ElevatedButton(
              onPressed: () {},
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
                    for (var i = 0; i < 10; i++) ...{
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
                              child: Text('U_000$i'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Name $i'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Email $i'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Store $i'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    color: Colors.blue,
                                    icon: Icon(Icons.visibility),
                                  ),
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    color: Colors.orange,
                                    icon: Icon(Icons.block),
                                  ),
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    color: Colors.red,
                                    icon: Icon(Icons.person_remove_sharp),
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
}
