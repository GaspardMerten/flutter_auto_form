import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';

abstract class FieldStatefulWidget extends StatefulWidget {
  const FieldStatefulWidget({Key? key}) : super(key: key);

  FieldContext get fieldContext;
}
