import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderSelector<P, T> extends ConsumerWidget {
  const ProviderSelector({
    required this.provider,
    required this.selector,
    required this.builder,
    super.key,
  });
  final ProviderListenable<P> provider;
  final T Function(P) selector;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(provider.select(selector));
    return builder(context, selected);
  }
}
