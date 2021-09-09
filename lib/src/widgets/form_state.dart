import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_auto_form/src/models/field/field.dart';
import 'package:flutter_auto_form/src/models/form.dart';
import 'package:flutter_auto_form/src/widgets/theme.dart';

import 'fields/fields.dart';

/// The [AFFormState] allows to override and customize even more the behavior
/// of the form widget's logic.
///
/// Before considering extending this class, make sure that the [AFWidget] class
/// does not satisfy your requirements!
abstract class AFFormState<T extends StatefulWidget, G extends TemplateForm>
    extends State<T> {
  AFFormState({
    required this.model,
    this.enableFinalAction = true,
    this.handleErrorOnSubmit,
  });

  /// The [TemplateForm] that will be used as the blueprint of this class.
  final G model;

  /// Whether to submit the form when the user clicks on the last field's [TextInputAction].
  final bool enableFinalAction;

  /// A callback that will be triggered whenever the [submitForm] method is called
  /// while the form is invalid. It exposes the first error returned by one of the
  /// form's field ([Field]
  final ValueChanged<String>? handleErrorOnSubmit;

  /// Whether to display each field's respective error (if there is one) even if
  /// the user did not interact with any of these fields.
  bool forceDisplayFieldsError = false;

  /// Since this getter makes use of the [context] value, it should not be
  /// called inside the [initState].
  AFThemeData get theme => AFTheme.of(context);

  /// A map linking each [AFTextField]'id to its respective [TextEditingController]
  /// that will be populated inside the [initState] method.
  Map<String, TextEditingController> textEditingControllers = {};

  /// A map linking each [AFTextField]'id to its respective [FocusNode]
  /// that will be populated inside the [initState] method.
  Map<String, FocusNode> focusNodes = {};

  @override
  void initState() {
    super.initState();

    for (final Field e in model.fields.whereType<AFTextField>()) {
      // Populate the [textEditingControllers] map for the given field.
      textEditingControllers[e.id] = TextEditingController(
        text: e.value?.toString(),
      )..addListener(
          () => e.value = textEditingControllers[e.id]!.text,
        );

      // Populate the [focusNodes] map for the given field.
      focusNodes[e.id] = FocusNode();
    }
  }

  @override
  void dispose() {
    // Disposes of each [TextEditingController] present inside the [textEditingControllers] map.
    textEditingControllers.forEach((_, controller) => controller.dispose());

    super.dispose();
  }

  /// Builds each [Field] contained inside the [TemplateForm].
  ///
  /// It then wraps all the fields inside an [AutofillGroup] for better autocompleting.
  Widget form() {
    final List<Widget> fieldWidgets = [];

    int _index = 0;

    for (final Field _field in model.fields) {
      final bool isFinal = _index == -1 || _index == model.fields.length - 1;

      final String? nextFocusId = isFinal ? null : model.fields[_index + 1].id;

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

  /// Returns the matching widget for a given [Field]
  Widget fieldWidget(
    Field field, {
    String? nextFocusName,
    bool isFinal = false,
  }) {
    if (field is AFTextField) {
      return buildTextField(nextFocusName, field, isFinal);
    } else if (field is AFSearchModelField) {
      final AutovalidateMode validateMode;

      if (forceDisplayFieldsError) {
        validateMode = AutovalidateMode.always;
      } else {
        validateMode = AutovalidateMode.onUserInteraction;
      }

      return buildSearchModelField(field, validateMode);
    } else if (field is AFBooleanField) {
      return buildBooleanField(field);
    }

    return theme.buildCustomField(nextFocusName, field, isFinal);
  }

  Padding buildBooleanField(AFBooleanField field) => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: InputDecorator(
          decoration: InputDecoration(
                  errorText: forceDisplayFieldsError
                      ? field.validate(field.value)
                      : null,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none)
              .applyDefaults(Theme.of(context).inputDecorationTheme),
          child: SwitchListTile(
            value: field.value ?? false,
            contentPadding: EdgeInsets.zero,
            onChanged: (e) => setState(() => field.value = e),
            title: Text(
              field.name,
              style: Theme.of(context).inputDecorationTheme.hintStyle,
            ),
          ),
        ),
      );

  Padding buildSearchModelField(
    AFSearchModelField<Object> field,
    AutovalidateMode validateMode,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        height: 64,
        child: SearchModelField(
          search: field.search,
          validator: field.validate,
          autoValidateMode: validateMode,
          onSelected: (e) => setState(() => field.value = e),
          label: field.name,
          selectedValue: field.value,
        ),
      ),
    );
  }

  Widget buildTextField(
    String? nextFocusName,
    AFTextField field,
    bool isFinal,
  ) {
    final FocusNode focusNode = focusNodes[field.id]!;

    final bool shouldObscureText = field.type == AFTextFieldType.PASSWORD ||
        field.type == AFTextFieldType.NEW_PASSWORD;

    FocusNode? nextFocusNode;

    if (nextFocusName != null) {
      nextFocusNode = focusNodes[nextFocusName];
    }

    return theme.textFieldWidgetBuilder(
      context,
      labelText: field.name,
      validator: (e) => field.validate(field.parser(e)),
      controller: textEditingControllers[field.id]!,
      action: isFinal ? TextInputAction.done : TextInputAction.next,
      autoFillHints: getAutoFillHintsFromFieldType(field),
      obscureText: shouldObscureText,
      focusNode: focusNode,
      forceError: forceDisplayFieldsError,
      completeAction: () async {
        if (isFinal && enableFinalAction) {
          await submitForm(showLoading: true);
        } else if (nextFocusNode != null) {
          focusNode.unfocus();
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
    );
  }

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

  FutureOr<void> submit(G form);

  Future<void> submitForm({bool showLoading = false}) async {
    setState(() {
      forceDisplayFieldsError = true;
    });

    if (model.isComplete()) {
      if (showLoading && enableFinalAction) {
        await theme.showFutureLoadingWidget(
          context: context,
          future: submit(model),
        );
      } else {
        await submit(model);
      }
    } else {
      handleErrorOnSubmit?.call(model.getFirstError()!);
    }
  }
}
