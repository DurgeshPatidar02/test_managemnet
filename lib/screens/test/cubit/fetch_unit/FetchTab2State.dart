abstract class FetchTab2State{}
class FetchTab2Initial extends FetchTab2State{}
class FetchTab2Loading extends FetchTab2State{}
class FetchTab2Created extends FetchTab2State{}
class FetchTab2Exist extends FetchTab2State{}
class FetchTab2Error extends FetchTab2State{
  String msg ;
  FetchTab2Error ({required this.msg});
}