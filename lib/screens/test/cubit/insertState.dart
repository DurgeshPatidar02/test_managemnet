import '../model/questionModel.dart';

abstract class InsertState {}

class ExcelInitial extends InsertState {}

class ExcelLoading extends InsertState {}

class ExcelSuccess extends InsertState {
  final int totalQuestions;
  final List<int> invalidAnswerIds;
  final String fileName;
  final List<QuestionModel> questions;

  ExcelSuccess(
      {required this.fileName,
      required this.totalQuestions,
      required this.invalidAnswerIds,
      // required this.readyToUpload,
      required this.questions});
}

class ExcelUploadSuccess extends InsertState {}

class ExcelUploadError extends InsertState {
  String msg;
  ExcelUploadError({required this.msg});
}

class UploadSuccess extends InsertState {}

class UploadError extends InsertState {
  String msg;
  UploadError ({required this.msg});
}

class ExcelError extends InsertState {
  final String message;

  ExcelError({required this.message});
}
