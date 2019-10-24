import 'package:dart_filter/dart_filter.dart';

/// A criteria that accepts all values.
class AcceptAllCriteria<T> extends FilterCriteria<T> {
  const AcceptAllCriteria();

  @override
  bool accepts(T t) => true;

  @override
  bool operator ==(Object other) => other is AcceptAllCriteria;

  @override
  int get hashCode => 1;
}

/// A criteria that accepts no values.
class AcceptNoneCriteria<T> extends FilterCriteria<T> {
  const AcceptNoneCriteria();

  @override
  bool accepts(T t) => false;

  @override
  bool operator ==(Object other) => other is AcceptNoneCriteria;

  @override
  int get hashCode => 0;
}

/// Accepts values that meet all the provided criteria.
///
/// The given criteria cannot be null but can be empty.
///
/// If no criteria are provided then the [defaultCriteria] is used which
/// defaults to [AcceptAllCriteria].
///
/// No == and hashCode.
class AndCriteria<T> extends FilterCriteria<T> {
  final FilterCriteria<T> defaultCriteria;

  final Iterable<FilterCriteria<T>> criteria;

  const AndCriteria(this.criteria, {this.defaultCriteria})
      : assert(criteria != null);

  @override
  bool accepts(T t) {
    if (criteria.isEmpty) {
      // default criteria set here because type parameters can't
      // be set for optional constructor parameters.
      return (defaultCriteria ?? AcceptAllCriteria<T>()).accepts(t);
    } else {
      for (final _criteria in criteria) {
        if (!_criteria.accepts(t)) return false;
      }

      return true;
    }
  }
}

/// Accepts values that meet one of the provided criteria.
///
/// The given criteria cannot be null but can be empty.
///
/// If no criteria are provided then the [defaultCriteria] is used which
/// defaults to [AcceptAllCriteria].
///
/// No == and hashCode.
class OrCriteria<T> extends FilterCriteria<T> {
  final FilterCriteria<T> defaultCriteria;

  final Iterable<FilterCriteria<T>> criteria;

  const OrCriteria(this.criteria,
      {this.defaultCriteria = const AcceptNoneCriteria()})
      : assert(criteria != null);

  @override
  bool accepts(T t) {
    if (criteria.isEmpty) {
      return defaultCriteria.accepts(t);
    } else {
      for (final _criteria in criteria) {
        if (_criteria.accepts(t)) return true;
      }

      return false;
    }
  }
}

/// Accepts values that meet only one of the provided criteria.
///
/// The given criteria cannot be null but can be empty.
///
/// If no criteria are provided then the [defaultCriteria] is used which
/// defaults to [AcceptAllCriteria].
///
/// No == and hashCode.
class XOrCriteria<T> extends FilterCriteria<T> {
  final FilterCriteria<T> defaultCriteria;

  final Iterable<FilterCriteria<T>> criteria;

  const XOrCriteria(this.criteria,
      {this.defaultCriteria = const AcceptNoneCriteria()})
      : assert(criteria != null);

  @override
  bool accepts(T t) {
    if (criteria.isEmpty) {
      return defaultCriteria.accepts(t);
    } else {
      final Iterable<bool> meets = criteria.map((a) => a.accepts(t));

      /// If meets contains only a single true value then only
      /// one criteria is accepted which equals an XOR.
      return meets.where((a) => a).length == 1;
    }
  }
}

/// Accepts only values that do not meet the passed criteria.
///
/// The given criteria cannot be null.
///
/// No == and hashCode.
class NotCriteria<T> extends FilterCriteria<T> {
  final FilterCriteria<T> criteria;

  const NotCriteria(this.criteria) : assert(criteria != null);

  @override
  bool accepts(T t) => !criteria.accepts(t);
}

/// Provide a custom criteria without subclassing [FilterCriteria].
///
/// No == and hashCode.
class AnonymousCriteria<T> extends FilterCriteria<T> {
  final bool Function(T t) criteria;

  const AnonymousCriteria(this.criteria) : assert(criteria != null);

  @override
  bool accepts(T t) => criteria(t);
}

/// Allows you to use existing filters on model objects of type [M]
/// by specifying a mapping function from [M] to [M].
///
/// No == and hashCode.
class MapCriteria<M, T> extends FilterCriteria<M> {
  final bool Function(T t) criteria;

  final T Function(M) mapTo;

  const MapCriteria(this.mapTo, this.criteria) : assert(criteria != null);

  @override
  bool accepts(M t) => criteria(mapTo(t));
}

/// Uses the == operator to compare a value and accepts only when that is true.
class EqualsCriteria<T> extends FilterCriteria<T> {
  final T value;

  const EqualsCriteria(this.value);

  @override
  bool accepts(T t) => t == value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EqualsCriteria &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
