import 'package:dart_filter/dart_filter.dart';

/// Wraps a filter that can ignore capitalization.
abstract class CapitalizationFilter extends FilterCriteria<String> {
  final bool ignoreCapitalization;

  const CapitalizationFilter(this.ignoreCapitalization)
      : assert(ignoreCapitalization != null);

  @override
  bool accepts(String t) => acceptsCapitalization(t, ignoreCapitalization);

  bool acceptsCapitalization(String t, bool ignoreCapitalization);
}

/// Accepts a string if it starts with [startsWith]
/// taking [ignoreCapitalization] into consideration.
class StartsWithFilter extends CapitalizationFilter {
  final String startsWith;

  const StartsWithFilter(this.startsWith, bool ignoreCapitalization)
      : super(ignoreCapitalization);

  @override
  bool acceptsCapitalization(String t, bool ignoreCapizalization) {
    if (ignoreCapizalization) {
      return t.toLowerCase().startsWith(startsWith.toLowerCase());
    } else {
      return t.startsWith(startsWith);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StartsWithFilter &&
          runtimeType == other.runtimeType &&
          ignoreCapitalization == other.ignoreCapitalization &&
          startsWith == other.startsWith;

  @override
  int get hashCode => startsWith.hashCode ^ ignoreCapitalization.hashCode;
}

/// Accepts a string if it ends with [endsWith]
/// taking [ignoreCapitalization] into consideration.
class EndsWithFilter extends CapitalizationFilter {
  final String endsWith;

  const EndsWithFilter(this.endsWith, bool ignoreCapitalization)
      : super(ignoreCapitalization);

  @override
  bool acceptsCapitalization(String t, bool ignoreCapizalization) {
    if (ignoreCapizalization) {
      return t.toLowerCase().endsWith(endsWith.toLowerCase());
    } else {
      return t.endsWith(endsWith);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EndsWithFilter &&
          runtimeType == other.runtimeType &&
          ignoreCapitalization == other.ignoreCapitalization &&
          endsWith == other.endsWith;

  @override
  int get hashCode => endsWith.hashCode ^ ignoreCapitalization.hashCode;
}

/// Accepts a string if it contains [contains]
/// taking [ignoreCapitalization] into consideration.
///
/// Accepts all if [contains] is null.
class ContainsFilter extends CapitalizationFilter {
  final String contains;

  const ContainsFilter(this.contains, bool ignoreCapitalization)
      : super(ignoreCapitalization);

  @override
  bool acceptsCapitalization(String t, bool ignoreCapizalization) {
    if (contains == null) {
      return true;
    }

    if (t == null) {
      return true;
    }

    if (ignoreCapizalization) {
      return t.toLowerCase().contains(contains.toLowerCase());
    } else {
      return t.contains(contains);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContainsFilter &&
          runtimeType == other.runtimeType &&
          ignoreCapitalization == other.ignoreCapitalization &&
          contains == other.contains;

  @override
  int get hashCode => contains.hashCode ^ ignoreCapitalization.hashCode;
}
