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
  int y1A;
  int y1P;
  int y2A;
  int y2P;
  int y3A;
  int y3P;
  int F1A;
  int F1P;
  int F2A;
  int F2P;
  int F3A;
  int F3P;

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<String>(columnName: 'criteria', value: criteria),
      DataGridCell<int>(columnName: 'y1Amount', value: y1A),
      DataGridCell<int>(columnName: 'y1Percentage', value: y1P),
      DataGridCell<int>(columnName: 'y2Amount', value: y2A),
      DataGridCell<int>(columnName: 'y2Percentage', value: y2P),
      DataGridCell<int>(columnName: 'y3Amount', value: y3A),
      DataGridCell<int>(columnName: 'y3Percentage', value: y3P),
      DataGridCell<int>(columnName: 'Forecast1A', value: F1A),
      DataGridCell<int>(columnName: 'Forecast1P', value: F1P),
      DataGridCell<int>(columnName: 'Forecast2A', value: F2A),
      DataGridCell<int>(columnName: 'Forecast2P', value: F2P),
      DataGridCell<int>(columnName: 'Forecast3A', value: F3A),
      DataGridCell<int>(columnName: 'Forecast3P', value: F3P),
    ]);
  }
}

// class DataSource extends DataGridSource {
//   DataSource(List<Data> data) {
//     dataGridRows = data
//         .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
//               DataGridCell<String>(
//                   columnName: 'criteria', value: criteria),
//               DataGridCell<int>(columnName: 'y1Amount', value: y1A),
//               DataGridCell<int>(
//                   columnName: 'y1Percentage', value: y1P),
//               DataGridCell<int>(columnName: 'y2Amount', value: y2A),
//               DataGridCell<int>(
//                   columnName: 'y2Percentage', value: y2P),
//               DataGridCell<int>(columnName: 'y3Amount', value: y3A),
//               DataGridCell<int>(
//                   columnName: 'y3Percentage', value: y3P),
//               DataGridCell<int>(
//                   columnName: 'Forecast2A', value: F1A),
//               DataGridCell<int>(
//                   columnName: 'Forecast1P', value: F1P),
//               DataGridCell<int>(
//                   columnName: 'Forecast2A', value: F2A),
//               DataGridCell<int>(
//                   columnName: 'Forecast2P', value: F2P),
//               DataGridCell<int>(
//                   columnName: 'Forecast2A', value: F3A),
//               DataGridCell<int>(
//                   columnName: 'Forecast3P', value: F3P),
//             ]))
//         .toList();
//   }

//   late List<DataGridRow> dataGridRows;
//   @override
//   List<DataGridRow> get rows => dataGridRows;

//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((dataGridCell) {
//       return Container(
//           padding: EdgeInsets.symmetric(horizontal: 8.0),
//           alignment: (dataGridCell.columnName == 'id' ||
//                   dataGridCell.columnName == 'salary')
//               ? Alignment.centerRight
//               : Alignment.centerLeft,
//           child: Text(
//             dataGridCell.value.toString(),
//             overflow: TextOverflow.ellipsis,
//           ));
//     }).toList());
//   }
// }
