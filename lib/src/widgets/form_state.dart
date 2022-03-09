import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';

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
    this.enableSubmitFormWrapper,
  });

  /// The [TemplateForm] that will be used as the blueprint of this class.
  final G model;

  /// Whether to submit the form when the user clicks on the last field's [TextInputAction].
  final bool enableFinalAction;

  /// Whether to use wrap the submit function inside the [AFThemeData.submitFormWrapper]
  /// function. This can be useful to display a loading dialog while submitting
  /// the data.
  final bool? enableSubmitFormWrapper;

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

  /// A map linking each form field [AFFormField] to its counterpart [AFFormState] instance.
  /// allowing this very widget to validate (display errors) and retrieve data from
  /// the sub-form.
  final Map<String, GlobalKey<AFWidgetState>> formsState = {};

  /// A map linking each form field [AFMultipleFormField] to its counterpart
  /// [AFMultipleFormFieldWidgetState] instance.
  ///
  /// The [AFMultipleFormFieldWidgetState] exposes a save method which when
  /// called, validate the data and saves it (if valid) inside the value attribute
  /// of the [AFMultipleFormField] object.
  final Map<String, GlobalKey<AFMultipleFormFieldWidgetState>>
      multipleFormsState = {};

  final Map<String, FieldContext> _fieldContexts = {};

  @override
  void initState() {
    super.initState();

    FieldContext? previousFieldContext;

    for (int index = 0; index < model.fields.length; index++) {
      final bool isLast = index == model.fields.length - 1;

      final field = model.fields[index];

      final fieldContext = FieldContext(
        field: field,
        forceErrorDisplay: forceDisplayFieldsError,
        completeAction: () {},
        isLast: isLast,
        previousFieldContext: previousFieldContext,
      );

      previousFieldContext?.nextFieldContext = fieldContext;

      if (isLast) {
        fieldContext.nextFieldContext = null;
      }

      _fieldContexts[field.id] = fieldContext;

      previousFieldContext = fieldContext;
    }
  }

  /// Builds each [Field] contained inside the [TemplateForm].
  ///
  /// It then wraps all the fields inside an [AutofillGroup] for better autocompleting.
  Widget form() {
    final List<Widget> fieldWidgets = [
      for (Field field in model.fields)
        field.widgetConstructor(fieldContext: _fieldContexts[field.id]!)
    ];

    return AutofillGroup(
      child: Column(
        children: fieldWidgets,
      ),
    );
  }

  FutureOr<void> submit(G form);

  Future<void> submitForm() async {
    setState(() {
      forceDisplayFieldsError = true;
    });

    bool shouldStop = false;

    formsState.forEach((key, value) {
      value.currentState?.submitForm();

      shouldStop |= !value.currentState!.model.isComplete();
    });

    multipleFormsState.forEach((key, value) {
      shouldStop |= !value.currentState!.save();
    });

    if (!shouldStop) {
      if (model.isComplete()) {
        final bool _enabledSubmitFormWrapper = enableSubmitFormWrapper ??
            AFTheme.of(context).enableSubmitFormWrapper;

        if (_enabledSubmitFormWrapper && enableFinalAction) {
          await theme.submitFormWrapper(
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

  String? getErrorText(Field field) {
    if (forceDisplayFieldsError) {
      return field.validate(field.value);
    }
    return null;
  }
}
