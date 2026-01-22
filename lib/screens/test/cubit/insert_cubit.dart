import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_managment/screens/test/model/fileModel.dart';
import 'package:test_managment/services/file_picker/exel_file_picker.dart';

import '../model/questionModel.dart';
import '../model/testModel.dart';
import '../model/unitModel.dart';
import 'insertState.dart';

class InsertCubit extends Cubit<InsertState> {
  InsertCubit() : super(ExcelInitial());

  Future<List<UnitModel>> fetchUnits() async {
    final response = await Supabase.instance.client
        .schema('test')
        .from('units')
        .select()
        .order('unit_name');

    return (response as List).map((e) => UnitModel.fromJson(e)).toList();
  }

  Future<void> excelPickAndRead() async {
    try {
      emit(ExcelLoading());
      FilePickerResult? result = await ExcelFileOperation.filePicker();
      if (result == null) {
        emit(ExcelError(message: "File Not Selected"));
      } else {
        List<FileModel>? fileData =
            await ExcelFileOperation.fileOperation(result: result);
        if (fileData != null) {
          String fileName = fileData[0].testName;
          int totalQuestions = fileData[0].totalQuestion;
          List<int> invalidAnswerIds = fileData[0].invalidIds;
          List<QuestionModel> questions = fileData[0].questions;

          emit(ExcelSuccess(
              fileName: fileName,
              totalQuestions: totalQuestions,
              invalidAnswerIds: invalidAnswerIds,
              questions: questions));
        }
      }
    } catch (e) {
      emit(ExcelError(message: e.toString()));
    }
  }

  Future<void> uploadTest(TestModel test, List<QuestionModel> question) async {
    try {
      //final json for upload
      Map<String, dynamic> testJsonData = test.toJson();
      Map<String, dynamic> questionsJsonData = test.toJson();
      final supabase = Supabase.instance.client;
      try {
        final response =
            await supabase.schema('test').from('tests').insert(testJsonData);
        final response2 = await supabase
            .schema('test')
            .from('questions')
            .insert(questionsJsonData);
        if (response == null && response2 == null) {
          emit(UploadSuccess());
        }
      } catch (e) {
        print(e);
        emit(UploadError(msg: e.toString()));
      }
    } catch (e) {
      print(e);
      emit(ExcelUploadError(msg: e.toString()));
    }
  }
}
