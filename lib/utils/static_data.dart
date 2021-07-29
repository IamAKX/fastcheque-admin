// This data is only for demo purpose.
// The useability of the constants from this files must be checked before
// publishing the app

import 'package:fastcheque_admin/model/dashboard_metrics_model.dart';
import 'package:fastcheque_admin/model/store_model.dart';
import 'package:fastcheque_admin/model/transaction_model.dart';
import 'package:flutter/material.dart';

List<DashboardMetricsModel> DASHBOARD_METIC_LIST = [
  DashboardMetricsModel(
    color: Colors.green,
    name: 'Users',
    svgSrc: 'assets/svg/user.svg',
    count: 18,
  ),
  DashboardMetricsModel(
    color: Colors.blue,
    name: 'Transcations',
    svgSrc: 'assets/svg/transfer.svg',
    count: 76,
  ),
  DashboardMetricsModel(
      color: Colors.yellow,
      name: 'Business Units',
      svgSrc: 'assets/svg/store.svg',
      count: 3),
  DashboardMetricsModel(
      color: Colors.red,
      name: 'Approval Request',
      svgSrc: 'assets/svg/notification.svg',
      count: 5),
];

List<TransationModel> TRANSACTION_LIST = [
  TransationModel(
      chequeNumber: 'CQ_00001',
      staffName: 'Peter Parker',
      managerName: 'Tony Stark',
      businessUnit: 'BU Avenger 2',
      date: '06/25/2021'),
  TransationModel(
      chequeNumber: 'CQ_00002',
      staffName: 'Steve Rogers',
      managerName: 'Thor Odinson',
      businessUnit: 'BU Avenger 1',
      date: '06/24/2021'),
  TransationModel(
      chequeNumber: 'CQ_00003',
      staffName: 'Peter Parker',
      managerName: 'Natasha Romanoff',
      businessUnit: 'BU Avenger 2',
      date: '06/24/2021'),
  TransationModel(
      chequeNumber: 'CQ_00004',
      staffName: 'Bruce Banner',
      managerName: 'Clint Barton',
      businessUnit: 'BU Avenger 1',
      date: '06/23/2021'),
  TransationModel(
      chequeNumber: 'CQ_00005',
      staffName: 'Stephen Strange',
      managerName: 'Thanos',
      businessUnit: 'BU Avenger 3',
      date: '06/22/2021'),
];

List<StoreModel> STORE_LIST = [
  // StoreModel(id: '1', name: 'Store 1', email: 'store1@email.com'),
  // StoreModel(id: '2', name: 'Store 2', email: 'store2@email.com'),
  // StoreModel(id: '3', name: 'Store 3', email: 'store3@email.com'),
  // StoreModel(id: '4', name: 'Store 4', email: 'store4@email.com'),
];
