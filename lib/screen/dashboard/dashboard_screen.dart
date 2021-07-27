import 'package:fastcheque_admin/model/transaction_model.dart';
import 'package:fastcheque_admin/utils/color.dart';
import 'package:fastcheque_admin/utils/constants.dart';
import 'package:fastcheque_admin/utils/static_data.dart';
import 'package:fastcheque_admin/widgets/header.dart';
import 'package:fastcheque_admin/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: 'Dashboard'),
            SizedBox(
              height: defaultPadding,
            ),
            Text(
              'Important Metrics',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Responsive(
              desktop: MetricsCardGridView(
                childAspectRatio: Responsive.isDesktop(context) ? 1.2 : 1.1,
              ),
              mobile: MetricsCardGridView(
                crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
                childAspectRatio: 1,
              ),
              tablet: MetricsCardGridView(
                crossAxisCount: Responsive.isTablet(context) ? 2 : 4,
                childAspectRatio: 2,
              ),
            ),
            SizedBox(
              height: defaultPadding * 1.25,
            ),
            Text(
              'Recent Transaction',
              style: Theme.of(context).textTheme.subtitle1,
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
                    5: FixedColumnWidth(100),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: secondaryColor),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Cheque Number'),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Date'),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Initiator'),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Approver'),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Business Unit'),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Image'),
                          ),
                        ),
                      ],
                    ),
                    for (TransationModel tm in TRANSACTION_LIST) ...{
                      TableRow(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.white10))),
                        // decoration: BoxDecoration(color: secondaryColor),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(tm.chequeNumber),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(tm.date),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(tm.staffName),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(tm.managerName),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(tm.businessUnit),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OutlineButton(
                                color: primaryColor,
                                textColor: primaryColor,
                                onPressed: () => null,
                                child: Text('View'),
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

class MetricsCardGridView extends StatelessWidget {
  const MetricsCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 4,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        mainAxisSpacing: defaultPadding,
        crossAxisSpacing: defaultPadding,
      ),
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(defaultPadding * 0.75),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: DASHBOARD_METIC_LIST[index].color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    DASHBOARD_METIC_LIST[index].svgSrc,
                    height: 10,
                    width: 10,
                    color: DASHBOARD_METIC_LIST[index].color,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.keyboard_arrow_right_outlined,
                  ),
                )
              ],
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Text(
              DASHBOARD_METIC_LIST[index].name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '${DASHBOARD_METIC_LIST[index].count}',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(color: DASHBOARD_METIC_LIST[index].color),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
