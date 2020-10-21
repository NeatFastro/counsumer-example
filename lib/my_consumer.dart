import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef MyConsumerBuilder = Function(
  BuildContext context,
  dynamic state,
  Widget child,
);

class MyConsumer<T> extends ConsumerWidget {
  final provider;
  final MyConsumerBuilder builder;
  final Widget child;

  MyConsumer({
    this.provider,
    this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final T state = watch(provider);
    return builder(context, state, child);
  }
}
