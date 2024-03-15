extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension DoubleExtensions on double {
  String toStringWithoutTrailingZeros() {
    return toStringAsFixed(truncateToDouble() == this ? 0 : 1);
  }
}

extension DurationExtensions on Duration {
  String formatToString() {
    var converted = [
      inDays,
      inHours.remainder(24),
      inMinutes.remainder(60),
    ];
    String formatted = "";
    if (converted[0] > 0) {
      formatted = "$formatted${converted[0]} d ";
    }
    if (converted[1] > 0) {
      formatted = "$formatted${converted[1]} h ";
    }
    if (converted[2] > 0) {
      formatted = "$formatted${converted[2]} min ";
    }
    return formatted.trim();
  }
}
