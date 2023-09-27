import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/error.dart';
import 'package:flutter_auto_form/src/models/field/field.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';
import 'package:flutter_auto_form/src/models/form.dart';
import 'package:flutter_auto_form/src/widgets/theme.dart';

abstract class AFFormStatefulWidget<T> extends StatefulWidget {
  const AFFormStatefulWidget(
      {super.key,
      required this.formBuilder,
      required this.onSubmitted,
      required this.enableFinalAction,
      this.enableSubmitFormWrapper,
      this.handleErrorOnSubmit,
      this.submitButton});

  final T Function() formBuilder;

  final Function(T form) onSubmitted;

  final bool enableFinalAction;

  final bool? enableSubmitFormWrapper;

  final ValueChanged<String>? handleErrorOnSubmit;

  final Widget Function(Function() submit)? submitButton;
}

/// The [AFFormState] allows to override and customize even more the behavior
/// of the form widget's logic.
///
/// Before considering extending this class, make sure that the [AFWidget] class
/// does not satisfy your requirements!
abstract class AFFormState<T extends AFFormStatefulWidget<G>,
    G extends TemplateForm> extends State<T> {
  /// The [TemplateForm] that will be used as the blueprint of this class.
  late final G model;

  /// Whether to submit the form when the user clicks on the last field's [TextInputAction].
  late final bool enableFinalAction;

  /// Whether to use wrap the submit function inside the [AFThemeData.submitFormWrapper]
  /// function. This can be useful to display a loading dialog while submitting
  /// the data.
  late final bool? enableSubmitFormWrapper;

  /// A callback that will be triggered whenever the [submitForm] method is called
  /// while the form is invalid. It exposes the first error returned by one of the
  /// form's field ([Field]
  late final ValueChanged<String>? handleErrorOnSubmit;

  /// Whether to display each field's respective error (if there is one) even if
  /// the user did not interact with any of these fields.
  bool forceDisplayFieldsError = false;

  /// Since this getter makes use of the [context] value, it should not be
  /// called inside the [initState].
  AFThemeData get theme => AFTheme.of(context);

  final Map<String, FieldContext> _fieldContexts = {};

  @override
  void initState() {
    super.initState();

    model = widget.formBuilder();

    enableFinalAction = widget.enableFinalAction;

    enableSubmitFormWrapper = widget.enableSubmitFormWrapper;

    handleErrorOnSubmit = widget.handleErrorOnSubmit;

    FieldContext? previousFieldContext;

    for (int index = 0; index < model.fields.length; index++) {
      final bool isLast = index == model.fields.length - 1;

      final field = model.fields[index];

      final fieldContext = FieldContext(
        field: field,
        forceErrorDisplay: forceDisplayFieldsError,
        completeAction: isLast && enableFinalAction ? submitForm : null,
        previous: previousFieldContext,
      );

      previousFieldContext?.next = fieldContext;

      if (isLast) {
        fieldContext.next = null;
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
        field.widgetBuilder(
          fieldContext: _fieldContexts[field.id]!
            ..updateWith(
              forceErrorDisplay: forceDisplayFieldsError,
            ),
        )
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

    if (model.isComplete()) {
      final bool enabledSubmitFormWrapper = enableSubmitFormWrapper ??
          AFTheme.of(context).enableSubmitFormWrapper;

      try {
        if (enabledSubmitFormWrapper && enableFinalAction) {
          await theme.submitFormWrapper(
            context: context,
            future: submit(model),
          );
        } else {
          await submit(model);
        }
      } on SubmitException catch (exception) {
        handleErrorOnSubmit?.call(exception.errorMessage);
      }
    } else {
      handleErrorOnSubmit?.call(model.getFirstError()!);
    }
  }
}
