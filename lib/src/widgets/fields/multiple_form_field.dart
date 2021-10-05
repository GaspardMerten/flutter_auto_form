import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/field/field.dart';
import 'package:flutter_auto_form/src/models/form.dart';
import 'package:flutter_auto_form/src/widgets/form.dart';

class AFMultipleFormFieldWidget extends StatefulWidget {
  const AFMultipleFormFieldWidget({
    Key? key,
    required this.field,
  }) : super(key: key);

  final AFMultipleFormField field;

  @override
  State<AFMultipleFormFieldWidget> createState() {
    return AFMultipleFormFieldWidgetState();
  }
}

class AFMultipleFormFieldWidgetState extends State<AFMultipleFormFieldWidget> {
  final List<TemplateForm> forms = [];
  final List<GlobalKey<AFWidgetState>> formsWidgetState = [];

  bool save() {
    final List<Map<String, Object?>> data = [];

    for (final formState in formsWidgetState) {
      formState.currentState!.submitForm();
    }

    bool isComplete = true;

    for (final form in forms) {
      isComplete &= form.isComplete();
      data.add(form.toMap());
    }

    widget.field.value = data;

    return isComplete;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          for (int index = 0; index < forms.length; index++)
            Container(
              decoration: index + 1 == forms.length
                  ? null
                  : const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black12))),
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('#$index'),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            formsWidgetState.removeAt(index);
                            forms.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                  AFWidget(
                    key: formsWidgetState[index],
                    formBuilder: () => forms[index],
                    onSubmitted: (TemplateForm? form) {},
                  ),
                ],
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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            forms.add(widget.field.formGenerator());
            formsWidgetState.add(GlobalKey<AFWidgetState>());
          });
        },
        child: Padding(
          padding: titlePadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Name', style: TextStyle(fontSize: 12)),
              Icon(Icons.add),
            ],
          ),
        ),
      ),
    );
  }
}
