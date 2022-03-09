import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Data {
  Data(
    this.criteria,
    this.y1A,
    this.y1P,
    this.y2A,
    this.y2P,
    this.y3A,
    this.y3P,
    this.F1A,
    this.F1P,
    this.F2A,
    this.F2P,
    this.F3A,
    this.F3P,
  );

  late String criteria;
  double y1A;
  double y1P;
  double y2A;
  double y2P;
  double y3A;
  double y3P;
  double F1A;
  double F1P;
  double F2A;
  double F2P;
  double F3A;
  double F3P;

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<String>(columnName: 'criteria', value: criteria),
      DataGridCell<double>(columnName: 'y1Amount', value: y1A),
      DataGridCell<double>(columnName: 'y1Percentage', value: y1P),
      DataGridCell<double>(columnName: 'y2Amount', value: y2A),
      DataGridCell<double>(columnName: 'y2Percentage', value: y2P),
      DataGridCell<double>(columnName: 'y3Amount', value: y3A),
      DataGridCell<double>(columnName: 'y3Percentage', value: y3P),
      DataGridCell<double>(columnName: 'Forecast1A', value: F1A),
      DataGridCell<double>(columnName: 'Forecast1P', value: F1P),
      DataGridCell<double>(columnName: 'Forecast2A', value: F2A),
      DataGridCell<double>(columnName: 'Forecast2P', value: F2P),
      DataGridCell<double>(columnName: 'Forecast3A', value: F3A),
      DataGridCell<double>(columnName: 'Forecast3P', value: F3P),
    ]);
  }
}
