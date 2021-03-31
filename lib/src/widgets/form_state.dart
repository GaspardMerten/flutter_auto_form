import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/configuration/configuration.dart';
import 'package:flutter_auto_form/src/models/field/field.dart';
import 'package:flutter_auto_form/src/models/form.dart';

abstract class GAFormState<T extends StatefulWidget, G extends TemplateForm>
    extends State<T> {
  GAFormState(
    this.model, {
    this.enableFinalAction = true,
  });

  final G model;

  final bool enableFinalAction;

  bool forceError = false;

  Map<String, TextEditingController> textEditingControllers = {};
  Map<String, FocusNode> focusNodes = {};

  @override
  void initState() {
    super.initState();

    for (final Field e in model.fields) {
      textEditingControllers[e.id] =
          TextEditingController(text: e.value?.toString());
      textEditingControllers[e.id]
          .addListener(() => e.value = textEditingControllers[e.id].text);

      focusNodes[e.id] = FocusNode();
    }
  }

  @override
  void dispose() {
    textEditingControllers.forEach((_, controller) => controller.dispose());

    super.dispose();
  }

  Widget form() {
    final List<Widget> fieldWidgets = [];

    int _index = 0;

    for (final Field _field in model.fields) {
      bool isFinal = _index == -1 || _index == model.fields.length - 1;

      final String nextFocusId = isFinal ? null : model.fields[_index + 1].id;

      fieldWidgets.add(fieldWidget(
        _field,
        nextFocusName: nextFocusId,
        isFinal: isFinal,
      ));

      _index++;
    }

    return AutofillGroup(
      child: Column(
        children: fieldWidgets,
      ),
    );
  }

  Widget fieldWidget(
    Field field, {
    String nextFocusName,
    bool isFinal = false,
  }) {
    if (field is AutoFormTextField) {
      return buildTextField(nextFocusName, field, isFinal);
    }

    return AutoFormConfiguration().buildField(nextFocusName, field, isFinal);
  }

  Widget buildTextField(
    String nextFocusName,
    AutoFormTextField field,
    bool isFinal,
  ) {
    final FocusNode focusNode = focusNodes[field.id];

    final bool shouldObscureText =
        field.type == AutoFormTextFieldType.PASSWORD ||
            field.type == AutoFormTextFieldType.NEW_PASSWORD;

    FocusNode nextFocusNode;

    if (nextFocusName != null) {
      nextFocusNode = focusNodes[nextFocusName];
    }

    return AutoFormConfiguration().textFieldWidgetBuilder(
      context,
      labelText: field.name,
      validator: field.validate,
      controller: textEditingControllers[field.id],
      action: isFinal ? TextInputAction.done : TextInputAction.next,
      autoFillHints: getAutoFillHintsFromFieldType(field),
      obscureText: shouldObscureText,
      focusNode: focusNode,
      forceError: forceError,
      completeAction: () {
        if (isFinal && enableFinalAction) {
          submitForm(showLoading: true);
        } else if (nextFocusNode != null) {
          focusNode.unfocus();
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
    );
  }

  List<String> getAutoFillHintsFromFieldType(AutoFormTextField field) {
    String autoFillHint;

    switch (field.type) {
      case AutoFormTextFieldType.PASSWORD:
        autoFillHint = AutofillHints.password;
        break;
      case AutoFormTextFieldType.EMAIL:
        autoFillHint = AutofillHints.email;
        break;
      case AutoFormTextFieldType.USERNAME:
        autoFillHint = AutofillHints.username;
        break;
      case AutoFormTextFieldType.NEW_PASSWORD:
        autoFillHint = AutofillHints.newPassword;
        break;
      case AutoFormTextFieldType.NEW_USERNAME:
        autoFillHint = AutofillHints.newUsername;
        break;
      default:
        break;
    }

    return [if (autoFillHint != null) autoFillHint];
  }

  FutureOr<void> submit(G form);

  Future<void> submitForm({bool showLoading = false}) async {
    setState(() {
      forceError = true;
    });

    if (model.isComplete()) {
      if (showLoading && enableFinalAction) {
        await AutoFormConfiguration().showFutureLoadingWidget(
          context: context,
          future: submit(model),
        );
      } else {
        await submit(model);
      }
    }
  }
}
