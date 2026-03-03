import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_managment/screens/test/cubit/test/tab2/testTab2State.dart';

import '../../../model/testModel.dart';

class TestTab2Cubit extends Cubit<TestTab2State> {
  TestTab2Cubit() : super(TestTab2Initial());

  Future<void> createTest(TestModel test) async {
    final supabase = Supabase.instance.client;
    try {
      final result = await supabase
          .schema('test')
          .from('tests')
          .select('unit_id')
          .eq('unit_id', test.unit_id)
          .eq('testName', test.testName);

      if (result.isEmpty) {
        //insert data
        final response = await supabase
            .schema('test')
            .from('tests')
            .insert(test)
            .select('id');
        if(response.isNotEmpty){
          response[0]['id'];
        }
        emit(TestTab2Success(testId: "TestID"));
      } else {
        //already Exist
        emit(TestTab2Error(msg: "Already Exist"));
      }
    } catch (e) {
      emit(TestTab2Error(msg: "Error"));
    }
  }
}
