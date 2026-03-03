import 'package:test_managment/screens/test/model/testModel.dart';

abstract class TestTab2State {}

class TestTab2Initial extends TestTab2State {}

class TestTab2Loading extends TestTab2State {}

class TestTab2Success extends TestTab2State {
  String testId;

  TestTab2Success({required this.testId});
}

class TestTab2Error extends TestTab2State {
  String msg;

  TestTab2Error({required this.msg});
}

// class TestTab1NoTestFound extends TestTab2State {}
// class TestTab1DeleteSuccess extends TestTab2State {}
