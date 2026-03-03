import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_managment/screens/test/model/testModel.dart';
import 'package:test_managment/screens/test/testOperation/question/services/cmsServices/wordModel.dart';

import '../../../model/questionModel.dart';
import 'cmsFileState.dart';

class CmsFileCubit extends Cubit<CmsState> {
  CmsFileCubit() : super(CmsInitial());

  Future<void> getQuestions({required TestModel test}) async {
    emit(CmsLoading());
    final supabase = Supabase.instance.client;

    final response = await supabase
        .schema('test')
        .from('questions')
        .select()
        .eq('test_id', test.id as Object)
        .order('no', ascending: true);

    final questions =
        (response as List).map((e) => QuestionModel.fromJson(e)).toList();
    if (questions.isEmpty) {
      emit(CMSNoQuestionFound());
    } else {
      final data = WordModel(test: test, questions: questions);
      emit(CmsSuccess(data: data));
    }
  }

  Future<void> deleteQuestions({required TestModel test}) async {
    emit(CmsLoading());
    final supabase = Supabase.instance.client;

    try {
      final response = await supabase
          .schema('test')
          .from('questions')
          .delete()
          .eq('test_id', test.id as Object);
      // .order('no', ascending: true);
      if (response == null) {
        emit(CMSDeleteSuccess());
      } else {
        emit(CMSDeleteError(msg: "Error From DeleteQuestions"));
      }
    } catch (e) {
      emit(CMSDeleteError(msg: e.toString()));
    }
  }

  void zero() {
    emit(CmsInitial());
  }
}
