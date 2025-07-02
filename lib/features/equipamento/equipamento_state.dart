abstract class EquipamentoState {}

class EquipamentoInitialState extends EquipamentoState{}
class EquipamentoLoadingState extends EquipamentoState{}
class EquipamentoSuccessState extends EquipamentoState{}
class EquipamentoErrorState extends EquipamentoState{
  final String message;

  EquipamentoErrorState(this.message);
}