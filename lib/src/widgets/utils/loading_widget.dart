import 'package:flutter/material.dart';

/// The widget that is displayed by the [kShowFutureLoadingDialog].
class DefaultLoadingWidget extends StatelessWidget {
  const DefaultLoadingWidget({
    Key? key,
  }) : super(key: key);

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
