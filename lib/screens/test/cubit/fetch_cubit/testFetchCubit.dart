import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'testFetchState.dart';

class TestFetchCubit extends Cubit<TestFetchState>{
  TestFetchCubit(): super(TestFetchInitial());

  Future <void> fetchTest()async {
    emit(TestFechLoding());

    final supabase = Supabase.instance.client;

    final response = await supabase.from('tests').select();
    // emit(state)
  }
}