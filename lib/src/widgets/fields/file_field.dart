import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/field/defaults.dart';

/// Displays a field using [InputDecorator] which is rendered clickable through
/// a [GestureDetector]. Once clicked, it will launch the File Picker plugin and
/// will let the user pick a file of his choice.
class FileFieldWidget extends StatelessWidget {
  const FileFieldWidget({
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
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
    );

    if (result != null) {
      final PlatformFile file = result.files.first;
      onChanged(SimpleFile(file.name, file.bytes));
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
