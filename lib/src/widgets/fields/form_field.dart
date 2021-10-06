import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/field/field.dart';
import 'package:flutter_auto_form/src/widgets/form.dart';

/// Displays a sub form intended to be placed inside an [AFFormState] build method.
/// The [formKey] argument is used by the parent widget to call the submit
/// method of the [AFWidget] embedded in this widget state.
class FormFieldWidget extends StatefulWidget {
  const FormFieldWidget({
    Key? key,
    required this.formKey,
    required this.field,
  }) : super(key: key);

  final AFFormField field;
  final GlobalKey<AFWidgetState> formKey;

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  @override
  void initState() {
    super.initState();

    if (widget.field.required) {
      widget.field.form = widget.field.formGenerator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: Colors.black12,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleRow(),
          if (widget.field.form != null)
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: AFWidget(
                key: widget.formKey,
                formBuilder: () => widget.field.form!,
                onSubmitted: (_) {},
              ),
            ),
        ],
      ),
    );
  }

  Widget buildTitleRow() {
    const titlePadding = EdgeInsets.only(
      left: 16,
      right: 16,
      bottom: 8,
      top: 8,
    );

    Widget child = const Text('Name', style: TextStyle(fontSize: 12));

    if (!widget.field.required) {
      final Widget action;
      final Function() onPressed;

      if (widget.field.form == null) {
        action = const Icon(Icons.add);
        onPressed = () => setState(
              () {
                widget.field.form = widget.field.formGenerator();
              },
            );
      } else {
        action = const Icon(Icons.remove);
        onPressed = () => setState(
              () {
                widget.field.form = null;
              },
            );
      }

      child = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: titlePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                child,
                action,
              ],
            ),
          ),
        ),
      );
    } else {
      child = Padding(padding: titlePadding, child: child);
    }

    return child;
  }
}
