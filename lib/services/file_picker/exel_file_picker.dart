import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:test_managment/screens/test/model/fileModel.dart';

import '../../screens/test/model/questionModel.dart';

class ExcelFileOperation {
  static Future<FilePickerResult?> filePicker() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['xlsx'],
    );
    if (result == null) {
      return null;
    }
    return result;
  }

  static String getFileName({required FilePickerResult result}) {
    return result.files.single.name.split('.').first;
  }

  static Future<List<FileModel>?> fileOperation(
      {required FilePickerResult result}) async {
    final file = File(result.files.single.path!);
    final bytes = file.readAsBytesSync();
    final excel = Excel.decodeBytes(bytes);
    final fileName = result.files.single.name.split('.').first;

    final sheet = excel.tables.values.first;

    List<QuestionModel> questions = [];
    List<int> invalidAnswerIds = [];
    List<FileModel> returnbleList2 = [];

    // Skip header row → start from index 1
    for (int i = 1; i < sheet.rows.length; i++) {
      final row = sheet.rows[i];

      int no = int.tryParse(row[0]?.value.toString() ?? '') ?? 0;
      String question = row[1]?.value.toString() ?? '';
      String optionA = row[2]?.value.toString() ?? '';
      String optionB = row[3]?.value.toString() ?? '';
      String optionC = row[4]?.value.toString() ?? '';
      String optionD = row[5]?.value.toString() ?? '';
      String disc = row[6]?.value.toString() ?? '';
      String ansRaw = row[7]?.value.toString() ?? '';

      //  Answer Validation
      String? ans;
      if (["A", "B", "C", "D"].contains(ansRaw.toUpperCase())) {
        ans = ansRaw.toUpperCase();
      } else {
        ans = null;
        invalidAnswerIds.add(no);
      }

      questions.add(
        QuestionModel(
          no: no,
          question: question,
          optionA: optionA,
          optionB: optionB,
          optionC: optionC,
          optionD: optionD,
          disc: disc,
          ans: ans,
        ),
      );
    }
    // List<Map<String, dynamic>> data = questions.map((e)=> e.toJson()).toList();

     returnbleList2.add(FileModel(
        testName: fileName,
        questions: questions,
        totalQuestion: questions.length,
        invalidIds: invalidAnswerIds));

    return returnbleList2;
  }
}
