import 'package:test_managment/screens/test/model/testModel.dart';

abstract class TestTab1State {}

class TestTab1Initial extends TestTab1State {}

class TestTab1Loading extends TestTab1State {}

class TestTab1Success extends TestTab1State {
  List<TestModel> tests;

  TestTab1Success({required this.tests});
}

class TestTab1Error extends TestTab1State {
  String msg;

  TestTab1Error({required this.msg});
}

class TestTab1NoTestFound extends TestTab1State {}
class TestTab1DeleteSuccess extends TestTab1State {}
