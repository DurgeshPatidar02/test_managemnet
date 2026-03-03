import '../../../../model/questionModel.dart';
import '../../../../model/testModel.dart';

class WordModel {
  final TestModel test;
  final List<QuestionModel> questions;

  WordModel({
    required this.test,
    required this.questions,
  });
}


