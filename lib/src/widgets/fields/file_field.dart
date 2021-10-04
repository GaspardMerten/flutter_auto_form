import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/field/defaults.dart';

class FileField extends StatelessWidget {
  const FileField({
    Key? key,
    this.value,
    this.errorText,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  final String label;
  final SimpleFile? value;
  final ValueChanged<SimpleFile> onChanged;
  final String? errorText;

  Future<void> pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final PlatformFile file = result.files.first;
      if (file.bytes != null) {
        onChanged(SimpleFile(file.name, file.bytes));
      } else if (file.path != null) {
        onChanged(SimpleFile(file.name, await File(file.path!).readAsBytes()));
      }
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickFile,
      child: InputDecorator(
        isEmpty: value == null,
        decoration: InputDecoration(
          label: Text(label),
          errorText: errorText,
        ).applyDefaults(
          Theme.of(context).inputDecorationTheme,
        ),
        child: value == null ? null : Text(value!.name),
      ),
    );
  }
}
