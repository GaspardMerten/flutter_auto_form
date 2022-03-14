import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';
import 'package:flutter_auto_form/src/widgets/fields/interface.dart';

class FormFieldWidget<T extends TemplateForm> extends FieldStatefulWidget {
  FormFieldWidget({
    Key? key,
    required this.controller,
    required this.fieldContext,
  }) : super(key: key) {
    print(fieldContext.field.name);
    print(fieldContext.field.runtimeType);
  }

  @override
  State<FormFieldWidget<T>> createState() => _FormFieldWidgetState<T>();

  @override
  final FieldContext fieldContext;

  final AFFormFieldController controller;
}

class _FormFieldWidgetState<T extends TemplateForm>
    extends FieldState<FormFieldWidget<T>> {
  late final AFFormField<T> field = widget.fieldContext.field as AFFormField<T>;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      formKey.currentState?.enableForceDisplayError();
    });
  }

  final GlobalKey<AFFormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [BoxShadow(blurRadius: 1, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(field.name, style: Theme.of(context).textTheme.bodySmall),
          AFWidget(
            key: formKey,
            formBuilder: () => field.form,
            onSubmitted: (_) {
              return widget.fieldContext.completeAction?.call();
            },
          ),
        ],
      ),
    );
  }
}

class MultipleFormFieldWidget<T extends TemplateForm>
    extends FieldStatefulWidget {
  const MultipleFormFieldWidget({
    Key? key,
    required this.controller,
    required this.fieldContext,
  }) : super(key: key);

  @override
  State<MultipleFormFieldWidget<T>> createState() =>
      _MultipleFormFieldState<T>();

  @override
  final FieldContext fieldContext;

  final AFFormFieldController controller;
}

class _MultipleFormFieldState<T extends TemplateForm>
    extends FieldState<MultipleFormFieldWidget<T>> {
  late final AFMultipleFormField<T> field =
      widget.fieldContext.field as AFMultipleFormField<T>;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {});
  }

  final Map<T, GlobalKey<AFFormState>> formKeys = {};

  GlobalKey<AFFormState> getKey(T formInstance) {
    if (!formKeys.containsKey(formInstance)) {
      formKeys[formInstance] = GlobalKey();
    }

    return formKeys[formInstance]!;
  }

  @override
  Widget build(BuildContext context) {
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [BoxShadow(blurRadius: 1, color: Colors.black12)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(field.name, style: bodySmall),
          for (final T form in field.forms) ...[
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${field.forms.indexOf(form) + 1}',
                  style: bodySmall,
                ),
                IconButton(
                  onPressed: () => setState(() {
                    field.removeForm(form);
                    formKeys.remove(form);
                  }),
                  icon: Icon(Icons.delete, color: bodySmall?.color, size: 18),
                )
              ],
            ),
            AFWidget(
              key: getKey(form),
              formBuilder: () => form,
              onSubmitted: (_) {
                return widget.fieldContext.completeAction?.call();
              },
            ),
          ],
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => setState(() {
                  field.addForm();
                }),
                child: const Text('Add'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
