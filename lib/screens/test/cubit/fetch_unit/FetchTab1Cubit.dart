import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_managment/screens/test/cubit/fetch_unit/FetchTab1State.dart';
import 'package:test_managment/screens/test/model/unitModel.dart';

class FetchTab1Cubit extends Cubit<FetchTab1State> {
  FetchTab1Cubit() : super(FetchTab1Initial());

  Future<void> loadUnits() async {
    final supabase = Supabase.instance.client;

    emit(FetchTab1Loading());
    try {
      final response = await supabase
          .schema('test')
          .from('units')
          .select()
          .order('unit_name');
      final units =
          (response as List).map((e) => UnitModel.fromJson(e)).toList();

      if (response.isNotEmpty) {
        emit(FetchTab1Success(units: units));
      } else {
        emit(FetchTab1NoFound());
      }
    } catch (e) {
      print(e);
      emit(FetchTab1Error(msg: e.toString()));
    }
  }

  Future<void> deleteUnit(String unitId) async {
    final supabase = Supabase.instance.client;

    try {
      emit(FetchTab1Loading());

      final result = await supabase
          .schema('test')
          .from('units')
          .delete()
          .eq('id', unitId)
          .select();

      print(result);
      if (result == null) {}
      emit(FetchTab1Delete());
    } catch (e) {
      emit(FetchTab1Error(msg: e.toString()));
    }
  }
}
