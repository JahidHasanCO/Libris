import 'package:flutter/foundation.dart';

/// An extension on nullable [Object] to provide customizable console logging with
/// support for different text styles, colors, and background colors.
extension LogExtension on Object? {
  /// Prints a message to the console with optional formatting for text style, color, and background color.
  ///
  /// The message is printed with the specified level (color), style, and background color.
  /// The logging is only active in debug mode using `kDebugMode`.
  ///
  /// [prefix] allows you to add a custom prefix before the message (e.g., '[INFO]').
  /// [level] determines the text color. The default is blue (level 0).
  /// [style] sets the text style (e.g., 'reset', 'bright', 'dim'). Default is 'reset'.
  /// [background] sets the background color (e.g., 'black', 'red'). Default is 'black'.
  ///
  /// Example:
  /// ```dart
  /// 'This is an info message'.doPrint(level: 0, style: 'bright', background: 'yellow');
  /// ```
  ///
  /// The available levels are:
  /// - 0: Blue (Info)
  /// - 1: Green (Success)
  /// - 2: Yellow (Warning)
  /// - 3: Red (Error)
  ///
  /// The available styles are:
  /// - 'reset': Default style
  /// - 'bright': Bright text
  /// - 'dim': Dimmed text
  /// - 'underscore': Underlined text
  /// - 'blink': Blinking text
  /// - 'reverse': Reversed colors
  /// - 'hidden': Hidden text
  ///
  /// The available background colors are:
  /// - 'black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white'.
  void doPrint({
    String prefix = '',
    int level = 2,
    String style = 'reset',
    String background = 'reset',
  }) {
    if (!kDebugMode) return;
    // Mapping of text styles
    const styles = {
      'reset': '\x1B[0m',
      'bright': '\x1B[1m',
      'dim': '\x1B[2m',
      'underscore': '\x1B[4m',
      'blink': '\x1B[5m',
      'reverse': '\x1B[7m',
      'hidden': '\x1B[8m',
    };

    // Mapping of text colors based on level
    const colors = {0: '\x1B[34m', 1: '\x1B[32m', 2: '\x1B[33m', 3: '\x1B[31m'};

    // Mapping of background colors
    const bgColors = {
      'reset': '\x1B[0m',
      'black': '\x1B[40m',
      'red': '\x1B[41m',
      'green': '\x1B[42m',
      'yellow': '\x1B[43m',
      'blue': '\x1B[44m',
      'magenta': '\x1B[45m',
      'cyan': '\x1B[46m',
      'white': '\x1B[47m',
    };

    // Select the corresponding color and style, defaulting if necessary
    final color = colors[level] ?? '\x1B[34m';
    final textStyle = styles[style] ?? '\x1B[0m';
    final bgColor = bgColors[background] ?? '\x1B[40m';

    // Print message to console in debug mode
    if (kDebugMode) {
      print('$textStyle$bgColor$color$prefix $this\x1B[0m');
    }
  }
}