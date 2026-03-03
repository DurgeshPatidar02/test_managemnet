abstract class QuestionsState {}

class AddQuestionInitial extends QuestionsState {}

class AddQuestionLoading extends QuestionsState {}

class AddQuestionSuccess extends QuestionsState {}
class AddQuestionNothing extends QuestionsState {}

class AddQuestionError extends QuestionsState {
  String msg;

  AddQuestionError({required this.msg});
}
