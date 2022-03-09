import 'package:collection/src/iterable_extensions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp/datasource/data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'Model/data_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDks48kVjXP_i2zQrsgXV6A6EuaC9ccFEk",
      appId: "1:539969506078:android:bb4fe8532fff9ae111570f",
      messagingSenderId:
          "539969506078-ol5293jujh0qpjiajlqu72htmon8tcrm.apps.googleusercontent.com",
      projectId: "kainovation-a56bc",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kainovation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'FLutter editable table'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Data> _data = [];
  late DataSource _dataSource;
  late DataGridController _dataGridController;

  @override
  void initState() {
    super.initState();
    _dataSource = DataSource(_data);
    _dataGridController = DataGridController();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("data").snapshots(),
        builder: (context, snapshot) {
          _data = [];
          if (snapshot.connectionState == ConnectionState.waiting) {
          } else {
            snapshot.data!.docs.forEach((element) {
              _data.add(Data(
                  element.get('criteria'),
                  element.get('y1A'),
                  element.get('y1P'),
                  element.get('y2A'),
                  element.get('y2P'),
                  element.get('y3A'),
                  element.get('y3P'),
                  element.get('F1A'),
                  element.get('F1P'),
                  element.get('F2A'),
                  element.get('F2P'),
                  element.get('F3A'),
                  element.get('F3P')));
            });

            _dataSource = DataSource(_data);
          }

          return SafeArea(
              child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.blueGrey,
                  height: 100,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset('assets/images/logo.jpg',
                      //     width: 50, height: 50),

                      Text(
                        "DFCC  Credit Appraisal Calculation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: SfDataGrid(
                      gridLinesVisibility: GridLinesVisibility.both,
                      headerGridLinesVisibility: GridLinesVisibility.both,
                      //editingGestureType: EditingGestureType.tap,
                      navigationMode: GridNavigationMode.cell,
                      columnWidthMode: ColumnWidthMode.fill,
                      controller: _dataGridController,
                      allowEditing: true,
                      selectionMode: SelectionMode.single,
                      editingGestureType: EditingGestureType.tap,
                      source: _dataSource,
                      columns: [
                        GridTextColumn(
                            columnName: 'criteria',
                            allowEditing: false,
                            label: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Criteria',
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                        GridTextColumn(
                            columnName: 'y1Amount',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Amount',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridTextColumn(
                            columnName: 'y1Percentage',
                            // allowEditing: false,
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '%',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridTextColumn(
                            columnName: 'y2Amount',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Amount',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridTextColumn(
                            columnName: 'y2Percentage',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '%',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridTextColumn(
                            columnName: 'y3Amount',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Amount',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridTextColumn(
                            columnName: 'y3Percentage',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '%',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridTextColumn(
                            columnName: 'Forecast1A',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Amount',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridTextColumn(
                            columnName: 'Forecast1P',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '%',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridTextColumn(
                            columnName: 'Forecast2A',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Amount',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridTextColumn(
                            columnName: 'Forecast2P',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '%',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridTextColumn(
                            columnName: 'Forecast3A',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Amount',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridTextColumn(
                            columnName: 'Forecast3P',
                            label: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '%',
                                  overflow: TextOverflow.ellipsis,
                                ))),
                      ],
                      stackedHeaderRows: <StackedHeaderRow>[
                        StackedHeaderRow(cells: [
                          StackedHeaderCell(
                              columnNames: [
                                'y1Amount',
                                'y1Percentage',
                                'y2Amount',
                                'y2Percentage',
                                'y3Amount',
                                'y3Percentage'
                              ],
                              child: Container(
                                  color: const Color(0xFFF1F1F1),
                                  child: Center(child: Text('Year')))),
                          StackedHeaderCell(
                              columnNames: [
                                'Forecast1A',
                                'Forecast1P',
                                'Forecast2A',
                                'Forecast2P',
                                'Forecast3A',
                                'Forecast3P'
                              ],
                              child: Container(
                                  color: const Color(0xFFF1F1F1),
                                  child: Center(child: Text('Forecasting')))),
                        ]),
                        StackedHeaderRow(cells: [
                          StackedHeaderCell(
                              columnNames: ['y1Amount', 'y1Percentage'],
                              child: Container(
                                  color: const Color(0xFFF1F1F1),
                                  child: Center(child: Text('2013')))),
                          StackedHeaderCell(
                              columnNames: ['y2Amount', 'y2Percentage'],
                              child: Container(
                                  color: const Color(0xFFF1F1F1),
                                  child: Center(child: Text('2014')))),
                          StackedHeaderCell(
                              columnNames: ['y3Amount', 'y3Percentage'],
                              child: Container(
                                  color: const Color(0xFFF1F1F1),
                                  child: Center(child: Text('2015')))),
                          StackedHeaderCell(
                              columnNames: ['Forecast1A', 'Forecast1P'],
                              child: Container(
                                  color: const Color(0xFFF1F1F1),
                                  child: Center(child: Text('2016')))),
                          StackedHeaderCell(
                              columnNames: ['Forecast2A', 'Forecast2P'],
                              child: Container(
                                  color: const Color(0xFFF1F1F1),
                                  child: Center(child: Text('2017')))),
                          StackedHeaderCell(
                              columnNames: ['Forecast3A', 'Forecast3P'],
                              child: Container(
                                  color: const Color(0xFFF1F1F1),
                                  child: Center(child: Text('2018')))),
                        ])
                      ]),
                ),
                Expanded(
                    child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text("Powered by Kainovation Technologies"),
                        )))
              ],
            ),
          ));
        });
    //getDataFirebase();
    // firebaseFetch();
    // var dataF = getData();
    // print(dataF);
  }

  List<Data> getData() {
    return [
      Data(
        'Category 1',
        100000,
        0,
        150000,
        50,
        200000,
        20,
        100000,
        15,
        100000,
        10,
        100000,
        20,
      ),
      Data(
        'Category 2',
        100000,
        0,
        150000,
        50,
        200000,
        20,
        100000,
        0,
        100000,
        0,
        100000,
        0,
      ),
      Data(
        'Category 3',
        100000,
        0,
        150000,
        50,
        200000,
        20,
        100000,
        0,
        100000,
        0,
        100000,
        0,
      ),
      Data(
        'Category 4',
        100000,
        0,
        150000,
        50,
        200000,
        20,
        100000,
        0,
        100000,
        0,
        100000,
        0,
      ),
      Data(
        'Category 5',
        100000,
        0,
        150000,
        50,
        200000,
        20,
        100000,
        0,
        100000,
        0,
        100000,
        0,
      ),
    ];
  }
}
