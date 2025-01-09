import 'package:aegis/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/injection/dependency_injection.dart';
import '../../../core/navigation/navigation_service.dart';

class SliverAppBarScreen extends HookWidget {
  const SliverAppBarScreen({super.key});

  static final NavigationService ns = getIt();

  @override
  Widget build(BuildContext context) {
    var isSingleLine = useState(true);

    return SkScaffold(
      body: CustomScrollView(
        slivers: [
          SkSliverAppBar(
            onLeadingPressed: () => ns.pop(),
            isSingleLine: isSingleLine.value,
            title: isSingleLine.value
                ? 'Sliver App Bar'
                : 'Sliver App Bar with very long text that will activate the ellipsis effect of the title',
            actions: [
              IconButton(
                onPressed: () {
                  isSingleLine.value = !isSingleLine.value;
                },
                icon: Icon(
                  isSingleLine.value
                      ? Icons.toggle_off_rounded
                      : Icons.toggle_off_outlined,
                ),
              ),
            ],
          ),
          const SliverToBoxAdapter(
            child: Placeholder(fallbackHeight: 1000),
          ),
        ],
      ),
    );
  }
}
