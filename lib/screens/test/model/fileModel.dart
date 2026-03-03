
import 'questionModel.dart';

class FileModel {
  String testName;
  int totalQuestion;
  List<QuestionModel> questions;
  List<int> invalidIds;

  FileModel(
      {required this.totalQuestion,
      required this.testName,
      required this.questions,
      required this.invalidIds});

  Map<String, dynamic> toJson() => {
        "totalQuestion": totalQuestion,
        "testName": testName,
        "invalidIds": invalidIds,
        "questions": questions.map((e) => e.toJson()).toList(),
      };

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
        totalQuestion: json['totalQuestion'] as int,
        testName: json['testName'] as String,
        invalidIds: List<int>.from(json['invalidIds'] ?? []),
      questions: (json['questions'] as List? ?? []).map((e)=>QuestionModel.fromJson(e)).toList()
    );
  }
}
