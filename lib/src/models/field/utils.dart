import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/field/defaults.dart';

/// Returns the [AutofillHints] matching the [AFTextField.type].
List<String> getAutoFillHintsFromFieldType(AFTextField field) {
  String? autoFillHint;

  switch (field.type) {
    case AFTextFieldType.PASSWORD:
      autoFillHint = AutofillHints.password;
      break;
    case AFTextFieldType.EMAIL:
      autoFillHint = AutofillHints.email;
      break;
    case AFTextFieldType.USERNAME:
      autoFillHint = AutofillHints.username;
      break;
    case AFTextFieldType.NEW_PASSWORD:
      autoFillHint = AutofillHints.newPassword;
      break;
    case AFTextFieldType.NEW_USERNAME:
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
    case AFTextFieldType.EMAIL:
      inputType = TextInputType.emailAddress;
      break;
    case AFTextFieldType.USERNAME:
      inputType = TextInputType.name;
      break;
    case AFTextFieldType.NEW_PASSWORD:
      inputType = TextInputType.visiblePassword;
      break;
    case AFTextFieldType.PASSWORD:
      inputType = TextInputType.visiblePassword;
      break;
    case AFTextFieldType.NEW_USERNAME:
      inputType = TextInputType.name;
      break;
    case AFTextFieldType.NUMBER:
      inputType = TextInputType.number;
      break;
    default:
      break;
  }

  return inputType;
}
