import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_managment/screens/test/cubit/test/tab1/testTab1State.dart';
import 'package:test_managment/screens/test/model/unitModel.dart';

import '../../../model/testModel.dart';

class TestTab1Cubit extends Cubit<TestTab1State> {
  TestTab1Cubit() : super(TestTab1Initial());

  Future<void> loadTest({required UnitModel unit}) async {
    final supabase = Supabase.instance.client;

    emit(TestTab1Loading());
    try {
      final response = await supabase
          .schema('test')
          .from('tests')
          .select()
          .eq('unit_id', unit.id);
      if (response.isEmpty) {
        emit(TestTab1NoTestFound());
      } else {
        final tests =
            (response as List).map((e) => TestModel.fromJson(e)).toList();
        emit(TestTab1Success(tests: tests));
      }
    } catch (e) {
      emit(TestTab1Error(msg: e.toString()));
    }
  }

  Future<void> deleteTest(String testId) async {
    final supabase = Supabase.instance.client;

    try {
      emit(TestTab1Loading());

      final result = await supabase
          .schema('test')
          .from('tests')
          .delete()
          .eq('id', testId)
          .select();
      emit(TestTab1DeleteSuccess());
    } catch (e) {
      emit(TestTab1Error(msg: e.toString()));
    }
  }
}
