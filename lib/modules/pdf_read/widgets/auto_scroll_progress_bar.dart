import 'package:flutter/material.dart';
import 'package:libris/core/theme/colors.dart';

class AutoScrollProgressBar extends StatefulWidget {
  const AutoScrollProgressBar({
    required this.startTime,
    required this.durationSeconds,
    required this.isDarkMode,
    super.key,
  });
  final DateTime startTime;
  final int durationSeconds;
  final bool isDarkMode;

  @override
  State<AutoScrollProgressBar> createState() => _AutoScrollProgressBarState();
}

class _AutoScrollProgressBarState extends State<AutoScrollProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    final elapsed = DateTime.now().difference(widget.startTime).inMilliseconds;
    final remaining = (widget.durationSeconds * 1000) - elapsed;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: remaining.clamp(0, widget.durationSeconds * 1000),
      ),
    )..forward();
  }

  @override
  void didUpdateWidget(covariant AutoScrollProgressBar oldWidget) {
    if (widget.startTime != oldWidget.startTime ||
        widget.durationSeconds != oldWidget.durationSeconds) {
      _controller
        ..reset()
        ..duration = Duration(seconds: widget.durationSeconds)
        ..forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) => LinearProgressIndicator(
        value: _controller.value,
        minHeight: 4,
        backgroundColor: Colors.grey.withValues(alpha: 0.3),
        valueColor: AlwaysStoppedAnimation<Color>(
          widget.isDarkMode ? Colors.white : primaryColor,
        ),
      ),
    );
  }
}
