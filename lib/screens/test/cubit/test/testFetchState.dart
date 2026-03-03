abstract class TestFetchState{}

class TestFetchInitial extends TestFetchState{}

class TestFetchLoading extends TestFetchState{}

class TestFetchSuccess extends TestFetchState{}
class TestFetchError extends TestFetchState{
  String msg;
  TestFetchError({required this.msg});
}
