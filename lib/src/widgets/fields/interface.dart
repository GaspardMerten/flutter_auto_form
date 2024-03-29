import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';

abstract class FieldStatefulWidget extends StatefulWidget {
  const FieldStatefulWidget({Key? key}) : super(key: key);

  FieldContext get fieldContext;
}

abstract class FieldState<T extends FieldStatefulWidget> extends State<T> {
  @override
  void initState() {
    super.initState();

    widget.fieldContext.field.updateStream.listen(onChanged);
  }

  void onChanged(dynamic value) {
    setState(() {
      widget.fieldContext.onChanged(value);
    });
  }
}
