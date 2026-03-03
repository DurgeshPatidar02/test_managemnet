import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_managment/screens/test/cubit/bottomNavBar/BNBState.dart';

class BNBCubit extends Cubit<BNBState>{
  BNBCubit() : super(BNBInitial());

  void checkBNB({required int index}){
    String title = "QuestionsPage";
    emit(BNBIndex(index: index));
  }
}