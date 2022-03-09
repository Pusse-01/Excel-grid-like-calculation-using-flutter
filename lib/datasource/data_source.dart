import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myflutterapp/Model/data_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataSource extends DataGridSource {
  DataSource(this._data) {
    dataGridRows = _data
        .map<DataGridRow>((dataGridRow) => dataGridRow.getDataGridRow())
        .toList();
  }

  List<Data> _data = [];

  databaseset() async {
    Map<String, Object> data = {};
    for (var i in _data) {
      data = {
        'criteria': i.criteria,
        'y1A': i.y1A,
        'y1P': i.y1P,
        'y2A': i.y2A,
        'y2P': i.y2P,
        'y3A': i.y3A,
        'y3P': i.y3P,
        'F1A': i.F1A,
        'F1P': i.F1P,
        'F2A': i.F2A,
        'F2P': i.F2P,
        'F3A': i.F3A,
        'F3P': i.F3P,
      };

      print(data);

      await FirebaseFirestore.instance
          .collection('data')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          if (ds.get('criteria') == data['criteria']) {
            ds.reference.update(data);
          }
        }
      });
    }
  }

  List<DataGridRow> dataGridRows = [];

  /// Helps to hold the new value of all editable widget.
  /// Based on the new value we will commit the new value into the corresponding
  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }

  update(String column, int columnIndex, int rowIndex) {
    double val;
    if (column == 'y2Amount') {
      return val =
          ((_data[rowIndex].y2A - _data[rowIndex].y1A) / _data[rowIndex].y1A) *
              100;
    }
    if (column == 'y3Amount') {
      return val =
          ((_data[rowIndex].y3A - _data[rowIndex].y2A) / _data[rowIndex].y2A) *
              100;
    }
    if (column == 'Forecast1A') {
      return val =
          ((_data[rowIndex].F1A - _data[rowIndex].y3A) / _data[rowIndex].y3A) *
              100;
    }
    if (column == 'Forecast2A') {
      return val =
          ((_data[rowIndex].F2A - _data[rowIndex].F1A) / _data[rowIndex].F2A) *
              100;
    }
    if (column == 'Forecast3A') {
      return val =
          ((_data[rowIndex].F3A - _data[rowIndex].F2A) / _data[rowIndex].F2A) *
              100;
    }
  }

  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) async {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value ??
        '';
    int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }
    if (column.columnName == 'y1Amount') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'y1Amount', value: newCellValue);
      _data[dataRowIndex].y1A = newCellValue as double;
      var updatedVal =
          update('y1Amount', rowColumnIndex.columnIndex, dataRowIndex);
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex + 1] =
          DataGridCell<double>(
              columnName: 'y1Percentage', value: _data[dataRowIndex].y1P);
      _data[dataRowIndex].y1P = updatedVal.round();
    } else if (column.columnName == 'y1Percentage') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'y1Percentage', value: newCellValue);
      _data[dataRowIndex].y1P = newCellValue as double;
    } else if (column.columnName == 'y2Amount') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'y2Amount', value: newCellValue);
      _data[dataRowIndex].y2A = newCellValue as double;
      var updatedVal =
          update('y2Amount', rowColumnIndex.columnIndex, dataRowIndex);

      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex + 1] =
          DataGridCell<double>(
              columnName: 'y2Percentage', value: _data[dataRowIndex].y2P);
      _data[dataRowIndex].y2P = updatedVal.round();
      // print(" function");
      // print(updatedVal);
      // print(rowColumnIndex.columnIndex);
      // print(dataRowIndex);
    } else if (column.columnName == 'y2Percentage') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(
              columnName: 'y2Percentage', value: _data[dataRowIndex].y2P);
      _data[dataRowIndex].y2P = newCellValue as double;
    } else if (column.columnName == 'y3Amount') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'y3Amount', value: newCellValue);
      _data[dataRowIndex].y3A = newCellValue as double;
      var updatedVal =
          update('y3Amount', rowColumnIndex.columnIndex, dataRowIndex);
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex + 1] =
          DataGridCell<double>(
              columnName: 'y3Percentage', value: _data[dataRowIndex].y3P);
      _data[dataRowIndex].y3P = updatedVal.round();
      print(updatedVal);
    } else if (column.columnName == 'y3Percentage') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'y3Percentage', value: newCellValue);
      _data[dataRowIndex].y3P = newCellValue as double;
    } else if (column.columnName == 'Forecast1A') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'Forecast1A', value: newCellValue);
      _data[dataRowIndex].F1A = newCellValue as double;
      var updatedVal =
          update('Forecast1A', rowColumnIndex.columnIndex, dataRowIndex);
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex + 1] =
          DataGridCell<double>(
              columnName: 'Forecast1P', value: _data[dataRowIndex].F1P);
      _data[dataRowIndex].F1P = updatedVal.round();
    } else if (column.columnName == 'Forecast1P') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'Forecast1P', value: newCellValue);
      _data[dataRowIndex].F1P = newCellValue as double;
    } else if (column.columnName == 'Forecast2A') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'Forecast2A', value: newCellValue);
      _data[dataRowIndex].F2A = newCellValue as double;
      var updatedVal =
          update('Forecast2A', rowColumnIndex.columnIndex, dataRowIndex);
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex + 1] =
          DataGridCell<double>(
              columnName: 'Forecast2P', value: _data[dataRowIndex].F2P);
      _data[dataRowIndex].F2P = updatedVal.round();
    } else if (column.columnName == 'Forecast2P') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'Forecast2P', value: newCellValue);
      _data[dataRowIndex].F2P = newCellValue as double;
    } else if (column.columnName == 'Forecast3A') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'Forecast3A', value: newCellValue);
      _data[dataRowIndex].F3A = newCellValue as double;
      var updatedVal =
          update('Forecast3A', rowColumnIndex.columnIndex, dataRowIndex);
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex + 1] =
          DataGridCell<double>(
              columnName: 'Forecast3P', value: _data[dataRowIndex].F3P);
      _data[dataRowIndex].F3P = updatedVal.round();
    } else if (column.columnName == 'Forecast3P') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(columnName: 'Forecast3P', value: newCellValue);
      _data[dataRowIndex].F3P = newCellValue as double;
    }
    await databaseset();
  }

  @override
  bool canSubmitCell(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    // Return false, to retain in edit mode.
    return true; // or super.canSubmitCell(dataGridRow, rowColumnIndex, column);
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    final bool isNumericType = column.columnName != 'criteria';

    // Holds regular expression pattern based on the column type.
    final RegExp regExp = _getRegExp(isNumericType, column.columnName);

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        autocorrect: false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(regExp)
        ],
        keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = int.parse(value);
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          /// Call [CellSubmit] callback to fire the canSubmitCell and
          /// onCellSubmit to commit the new value in single place.
          submitCell();
        },
      ),
    );
  }

  RegExp _getRegExp(bool isNumericKeyBoard, String columnName) {
    return isNumericKeyBoard ? RegExp('[0-9]') : RegExp('[a-zA-Z ]');
  }
}
