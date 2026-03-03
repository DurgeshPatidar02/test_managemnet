abstract class BNBState {}

class BNBInitial extends BNBState{}
class BNBIndex extends BNBState{
  int index;
  BNBIndex({required this.index});
}