import 'package:flutter/material.dart';

class FormValidationManager {
  final _fieldStates = <String, FormFieldValidationState>{};

  FocusNode getFocusNodeForField(String key) {
    _ensureExists(key);

    return _fieldStates[key]!.focusNode;
  }

  static FormFieldValidator<T> validator<T>(
    FormValidationManager? formValidationManager, {
    required String key,
    required FormFieldValidator<T> validator,
  }) {
    if (formValidationManager != null) {
      return formValidationManager.wrapValidator(key, validator);
    }
    return validator;
  }

  FormFieldValidator<T> wrapValidator<T>(
    String key,
    FormFieldValidator<T> validator,
  ) {
    _ensureExists(key);

    return (input) {
      var result = validator(input);

      _fieldStates[key]!.hasError = result?.isNotEmpty ?? false;

      return result;
    };
  }

  bool get isNotEmpty => erroredFields.isNotEmpty;

  List<FormFieldValidationState> get erroredFields => _fieldStates.entries
      .where((s) => s.value.hasError)
      .map((s) => s.value)
      .toList();

  void _ensureExists(String key) {
    _fieldStates[key] ??= FormFieldValidationState(key: key);
  }

  void dispose() {
    for (var s in _fieldStates.entries) {
      s.value.focusNode.dispose();
    }
  }
}

class FormFieldValidationState {
  final String key;

  bool hasError;
  FocusNode focusNode;

  FormFieldValidationState({required this.key})
      : hasError = false,
        focusNode = FocusNode();
}
