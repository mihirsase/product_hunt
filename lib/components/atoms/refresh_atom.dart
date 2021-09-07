import 'package:flutter/material.dart';

class RefreshAtom extends StatelessWidget {
  final Widget  child;
  final Future<void>  Function() onRefresh;

  const RefreshAtom({
    required final this.child,
    required final this.onRefresh,
  });

  @override
  Widget  build(final BuildContext  _) {
    return RefreshIndicator(child: child, onRefresh: onRefresh);
  }
}

