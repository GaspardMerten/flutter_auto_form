import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/field/defaults.dart';

/// Returns the [AutofillHints] matching the [AFTextField.type].
List<String> getAutoFillHintsFromFieldType(AFTextField field) {
  String? autoFillHint;

  switch (field.type) {
    case AFTextFieldType.password:
      autoFillHint = AutofillHints.password;
      break;
    case AFTextFieldType.email:
      autoFillHint = AutofillHints.email;
      break;
    case AFTextFieldType.username:
      autoFillHint = AutofillHints.username;
      break;
    case AFTextFieldType.newPassword:
      autoFillHint = AutofillHints.newPassword;
      break;
    case AFTextFieldType.newUsername:
      autoFillHint = AutofillHints.newUsername;
      break;
    default:
      break;
  }

  return [if (autoFillHint != null) autoFillHint];
}

/// Returns the [TextInputType] matching the [AFTextField.type].
TextInputType? getTextInputType(AFTextField field) {
  TextInputType? inputType;

  switch (field.type) {
    case AFTextFieldType.email:
      inputType = TextInputType.emailAddress;
      break;
    case AFTextFieldType.username:
      inputType = TextInputType.name;
      break;
    case AFTextFieldType.newPassword:
      inputType = TextInputType.visiblePassword;
      break;
    case AFTextFieldType.password:
      inputType = TextInputType.visiblePassword;
      break;
    case AFTextFieldType.newUsername:
      inputType = TextInputType.name;
      break;
    case AFTextFieldType.number:
      inputType = TextInputType.number;
      break;
    default:
      break;
  }

  return inputType;
}
