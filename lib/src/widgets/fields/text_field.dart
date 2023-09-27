import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/field/field.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';
import 'package:flutter_auto_form/src/models/field/utils.dart';
import 'package:flutter_auto_form/src/widgets/fields/interface.dart';
import 'package:smarter_text_field/smarter_text_field.dart';

abstract class AFTextFieldWidgetStateFocusHelper<T extends FieldStatefulWidget>
    extends State<T> {
  final FocusNode focusNode = FocusNode();

  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = widget.fieldContext.focusStream.listen((event) {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _subscription.cancel();
  }
}

class AFTextFieldWidget extends FieldStatefulWidget {
  const AFTextFieldWidget({
    Key? key,
    required this.fieldContext,
  }) : super(key: key);

  @override
  final FieldContext fieldContext;

  @override
  State<AFTextFieldWidget> createState() => _AFTextFieldWidgetState();
}

class _AFTextFieldWidgetState
    extends AFTextFieldWidgetStateFocusHelper<AFTextFieldWidget> {
  late final AFTextField field = widget.fieldContext.field as AFTextField;

  late final TextEditingController controller = TextEditingController(
    text: field.value?.toString(),
  );

  @override
  void initState() {
    super.initState();

    field.updateStream.listen((event) {
      setState(() {
        controller.text = event == null ? '' : event.toString();
      });
    });

    controller
        .addListener(() => widget.fieldContext.onChanged(controller.text));
  }

  @override
  Widget build(BuildContext context) {
    final InputDecoration decoration = InputDecoration(
      labelText: field.name,
    ).applyDefaults(Theme.of(context).inputDecorationTheme);

    final bool obscureText = field.type == AFTextFieldType.password ||
        field.type == AFTextFieldType.newPassword;

    final TextInputAction keyboardAction;

    if (widget.fieldContext.isLast) {
      keyboardAction = TextInputAction.done;
    } else {
      keyboardAction = TextInputAction.next;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SmartTextFormField(
        decoration: decoration,
        maxLines: field.maxLines,
        validator: field.validator,
        controller: controller,
        autoFillHints: getAutoFillHintsFromFieldType(field),
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: getTextInputType(field),
        action: keyboardAction,
        forceError: widget.fieldContext.forceErrorDisplay,
        completeAction: widget.fieldContext.next?.sendRequestFocusEvent ??
            widget.fieldContext.completeAction,
        displayObscureTextToggle: obscureText,
      ),
    );
  }
}
