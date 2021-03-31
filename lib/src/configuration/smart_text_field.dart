import 'package:flutter/material.dart';

class SmartTextFormField extends StatefulWidget {
  const SmartTextFormField(
      {Key key,
      this.decoration,
      this.validator,
      this.controller,
      this.focusNode,
      this.obscureText,
      this.action,
      this.completeAction,
      this.forceError = false,
      this.autoFillHints = const [],
      this.displayObscureTextToggle = false})
      : super(key: key);

  final InputDecoration decoration;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool obscureText;
  final bool displayObscureTextToggle;
  final bool forceError;
  final TextInputAction action;
  final List<String> autoFillHints;
  final Function() completeAction;

  @override
  _SmartTextFormFieldState createState() => _SmartTextFormFieldState();
}

class _SmartTextFormFieldState extends State<SmartTextFormField> {
  bool hasBeenUnFocusOnce = false;
  bool hasBeenFocusOnce = false;
  bool forceError = false;
  bool obscureText = false;

  @override
  void initState() {
    super.initState();

    obscureText = widget.obscureText;

    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        setState(() {
          forceError = false;
        });
        hasBeenFocusOnce = true;
      }
      if (!widget.focusNode.hasFocus && hasBeenFocusOnce && mounted) {
        setState(() {
          hasBeenUnFocusOnce = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: widget.decoration.copyWith(
          suffixIcon: widget.displayObscureTextToggle
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off),
                )
              : null),
      validator: widget.validator,
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: obscureText,
      autovalidateMode: hasBeenUnFocusOnce || widget.forceError
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      textInputAction: widget.action,
      autofillHints: widget.autoFillHints,
      onFieldSubmitted: (_) {
        widget.completeAction?.call();
      },
    );
  }
}
