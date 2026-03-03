import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_managment/screens/test/model/fileModel.dart';
import 'package:test_managment/services/file_picker/exel_file_picker.dart';

import '../model/questionModel.dart';
import '../model/testModel.dart';
import '../model/unitModel.dart';
import 'fileInsertState.dart';

class FileInsertCubit extends Cubit<InsertState> {
  FileInsertCubit() : super(ExcelInitial());


  Future<void> excelPickAndRead({required test_id}) async {
    try {
      emit(ExcelLoading());
      FilePickerResult? result = await ExcelFileOperation.filePicker();
      if (result == null) {
        emit(ExcelError(message: "File Not Selected"));
      } else {
        List<FileModel>? fileData =
            await ExcelFileOperation.fileOperation(result: result, test_id: test_id);
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

  void zero(){
    emit(ExcelZero());
  }

}
