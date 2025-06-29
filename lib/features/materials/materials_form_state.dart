abstract class MaterialsFormState {}

class MateriaslFormInitialState extends MaterialsFormState {}

class MaterialsFormLoadingState extends MaterialsFormState {}

class MaterialsFormSuccessState extends MaterialsFormState {}

class MaterialsFormErrorState extends MaterialsFormState {
  final String message;

  MaterialsFormErrorState(this.message);
}
