import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

class CSVExporter {
  static Future<void> saveAsCSV(List<List<dynamic>> data) async {
    try {
      String csvData = const ListToCsvConverter().convert(data);

      final String dirPath = (await getExternalStorageDirectory())!.path;
      final String filePath = '$dirPath/data_export.csv';

      final File file = File(filePath);
      await file.writeAsString(csvData);

      print('Data exported successfully to: $filePath');
    } catch (e) {
      print('Error exporting data: $e');
    }
  }
}

class ExportDataScreen extends StatelessWidget {
  final List<List<dynamic>> dataList;

  ExportDataScreen({required this.dataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Export Data to CSV'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await CSVExporter.saveAsCSV(dataList);
          },
          child: Text('Export as CSV'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ExportDataScreen(
      dataList: [
        ['Name', 'Age', 'Location'],
        ['John', 25, 'New York'],
        ['Alice', 30, 'Los Angeles'],
        ['Bob', 28, 'Chicago'],
      ],
    ),
  ));
}
