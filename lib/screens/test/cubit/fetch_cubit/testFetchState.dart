abstract class TestFetchState{}

class TestFetchInitial extends TestFetchState{}

class TestFechLoding extends TestFetchState{}

class TestFetchSuccess extends TestFetchState{}
class TestFetchError extends TestFetchState{
  String msg;
  TestFetchError({required this.msg});
}
