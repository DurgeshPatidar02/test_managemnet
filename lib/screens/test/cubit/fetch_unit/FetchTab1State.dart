import 'package:test_managment/screens/test/model/unitModel.dart';

abstract class FetchTab1State {}

class FetchTab1Initial extends FetchTab1State {}

class FetchTab1Loading extends FetchTab1State {}

class FetchTab1NoFound extends FetchTab1State {}

class FetchTab1Delete extends FetchTab1State {}

class FetchTab1NoEdit extends FetchTab1State {}

class FetchTab1Success extends FetchTab1State {
  List<UnitModel> units;

  FetchTab1Success({required this.units});
}

class FetchTab1Error extends FetchTab1State {
  String msg;

  FetchTab1Error({required this.msg});
}
