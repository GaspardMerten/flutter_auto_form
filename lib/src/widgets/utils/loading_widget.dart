import 'dart:async';

import 'package:flutter/material.dart';

/// The widget that is displayed by the [kShowFutureLoadingDialog].
class DefaultLoadingWidget<T> extends StatefulWidget {
  const DefaultLoadingWidget({
    Key? key,
    required this.future,
    required this.popOnComplete,
  }) : super(key: key);

  final FutureOr<T> future;
  final bool popOnComplete;

  @override
  State<DefaultLoadingWidget<T>> createState() =>
      _DefaultLoadingWidgetState<T>();
}

class _DefaultLoadingWidgetState<T> extends State<DefaultLoadingWidget<T>> {
  @override
  void initState() {
    super.initState();

    if (widget.future is Future<T>) {
      (widget.future as Future<T>).then(_onComplete);
    } else {
      _onComplete(widget.future as T);
    }
  }

  void _onComplete(T value) {
    if (widget.popOnComplete) {
      Navigator.of(context).pop(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.5),
              color: Colors.white,
            ),
            child: const Material(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
