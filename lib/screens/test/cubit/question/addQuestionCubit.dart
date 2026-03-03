import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_managment/screens/test/cubit/question/addQuestionState.dart';

import '../../model/questionModel.dart';
import '../../model/testModel.dart';
import '../fileInsertState.dart';

class QuestionCubit extends Cubit<QuestionsState>{
  QuestionCubit () : super (AddQuestionInitial());

  Future<void> addQuestions(List<QuestionModel> question) async {
    emit(AddQuestionLoading());
    try {
      //final json for upload
      final questionsJsonData =
      question.map((e) => e.toJson()).toList();
      final supabase = Supabase.instance.client;
      try {
        final response = await supabase
            .schema('test')
            .from('questions')
            .insert(questionsJsonData);
        if (response == null) {
          emit(AddQuestionSuccess());

        }
      } catch (e) {
        print(e);
        emit(AddQuestionError(msg: e.toString()));
      }
    } catch (e) {
      print(e);
      emit(AddQuestionError(msg: e.toString()));
    }
  }

  void zero(){
    emit(AddQuestionNothing());
  }


  // Future<void> deleteQuestions(TestModel test) async {
  //   try {
  //
  //     final supabase = Supabase.instance.client;
  //     try {
  //       final response =
  //       await supabase.schema('test').from('questions').delete().eq('test_id', test.id.toString());
  //
  //       if (response == null && response2 == null) {
  //         emit(InsertQuestionSuccess());
  //       }
  //     } catch (e) {
  //       print(e);
  //       emit(InsertQuestionError(msg: e.toString()));
  //     }
  //   } catch (e) {
  //     print(e);
  //     emit(InsertQuestionError(msg: e.toString()));
  //   }
  // }

}