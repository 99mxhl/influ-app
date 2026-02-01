import 'package:intl/intl.dart';

extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - ellipsis.length)}$ellipsis';
  }
}

extension DateTimeExtensions on DateTime {
  String formatDate() {
    return DateFormat('MMM d, yyyy').format(this);
  }

  String formatDateTime() {
    return DateFormat('MMM d, yyyy h:mm a').format(this);
  }

  String formatTime() {
    return DateFormat('h:mm a').format(this);
  }

  String formatRelative() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 7) {
      return formatDate();
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension DoubleExtensions on double {
  String formatCurrency({String symbol = '\$'}) {
    return '$symbol${NumberFormat('#,##0.00').format(this)}';
  }

  String formatCompact() {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    }
    return toStringAsFixed(0);
  }
}

extension IntExtensions on int {
  String formatCompact() {
    return toDouble().formatCompact();
  }
}
