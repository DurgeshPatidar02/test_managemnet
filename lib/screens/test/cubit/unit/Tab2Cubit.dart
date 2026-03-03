import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Tab2State.dart';

class FetchTab2Cubit extends Cubit<FetchTab2State> {
  FetchTab2Cubit() : super(FetchTab2Initial());

  Future<void> createUnit({required String unitName}) async {
    emit(FetchTab2Loading());
    final supabase = Supabase.instance.client;
    try {
      final existing = await supabase
          .schema('test')
          .from('units')
          .select('id')
          .eq('unit_name', unitName.trim())
          .maybeSingle();

      if (existing != null) {
        // Unit already exists
        emit(FetchTab2Exist());
      }

      // Insert new unit
      await supabase
          .schema('test')
          .from('units')
          .insert({'unit_name': unitName})
          .select()
          .single();

      emit(FetchTab2Created());

      // _loadUnits();
      // _tabController.index = 0; // Switch to Unit List tab
    } catch (e) {
      print(e);
      emit(FetchTab2Error(msg: e.toString()));
    }
  }
}
