
import 'package:construtech/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  
  final bool isLoading;
  final T? value;
  final String labelText;
  final String hintText;
  final List<T> items; 
  final ValueChanged<T?> onChanged;
  final FormFieldValidator<T>? validator;

  final String Function(T item) itemBuilderText; 

  final defaulBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.purpleOne),
  );

  const CustomDropdownFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.onChanged,
    required this.itemBuilderText,
    this.value,
    this.validator,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : DropdownButtonFormField<T>(
              value: value,
              hint: Text(hintText),
              decoration: InputDecoration(
                labelText: labelText.toUpperCase(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: defaulBorder,
                errorBorder: defaulBorder.copyWith(
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: defaulBorder.copyWith(
                  borderSide: const BorderSide(color: Colors.red),
                ),
                enabledBorder: defaulBorder,
                disabledBorder: defaulBorder,
              ),
              validator: validator,
              items: items.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(itemBuilderText(item)), 
                );
              }).toList(),
              onChanged: onChanged,
            ),
    );
  }
}