import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

///Navigation return interception
class WillPopScopeRoute extends StatefulWidget {
  const WillPopScopeRoute({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<WillPopScopeRoute> createState() => _WillPopScopeRouteState();
}

class _WillPopScopeRouteState extends State<WillPopScopeRoute> {
  DateTime? lastPressedAt; //Last click time

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        SmartDialog.showToast('Press again to exit');
        if (lastPressedAt == null ||
            DateTime.now().difference(lastPressedAt!) >
                const Duration(seconds: 1)) {
          //If the interval between two clicks exceeds 1 second, the time will be reset.
          lastPressedAt = DateTime.now();
          return;
        }
        SystemNavigator.pop();
      },
      child: widget.child,
    );
  }
}
