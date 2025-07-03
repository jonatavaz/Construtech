abstract class MaterialsState {}

class MaterialsInitialState extends MaterialsState {}

class MaterialsLoadingState extends MaterialsState {}

class MaterialsSuccessState extends MaterialsState {}

class MaterialsErrorState extends MaterialsState {
  final String message;

  MaterialsErrorState(this.message);
}