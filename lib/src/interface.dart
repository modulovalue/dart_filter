import 'package:dart_filter/dart_filter.dart';

/// A way to filter collections by using advanced criteria.
///
/// Loosely based on
/// https://www.tutorialspoint.com/design_pattern/filter_pattern.htm
///
/// Pass the criteria for which to filter as a list of [T]
///
/// If no criteria are provided then the [defaultCriteria] is used which
/// defaults to [AcceptAllCriteria].
///
/// You can also ignore the [CriteriaFilter] altogether and use subclasses
/// of FilterCriteria inside Iterable.where by using their accept method.
///
/// Available criteria:
///
/// - [AcceptAllCriteria]   : Lets everything through.
/// - [AcceptNoneCriteria]  : Lets nothing through.
/// - [AndCriteria]         : Lets a value only through if it meets all criteria.
/// - [OrCriteria]          : Lets a value only through if it meets at least one criteria.
/// - [XOrCriteria]         : Lets a value only through if it meets only one criteria.
/// - [NotCriteria]         : Lets a value through if it doesn't meet the provided criteria.
/// - [AnonymousCriteria]   : Lets you provide a criteria in the constructor without subclassing.
///
/// For custom criteria subclass [FilterCriteria].
///
/// --
///
/// Base class for criteria.
abstract class FilterCriteria<T> {
  const FilterCriteria();

  /// Return true when the item is accepted and should not be filtered out.
  bool accepts(T t);

  /// call is overridden so that every criteria can be passed to the
  /// .where call on iterables directly.
  bool call(T t) => accepts(t);

  /// Allows the current filter to be used on objects that can be mapped to [T].
  ///
  /// Example: A user can have a name. But the criteria may only be defined in terms
  /// of the users name, only a string. With this or [MapCriteria] you can take that criteria for a string
  /// and apply it to a user by telling which property of the user the criteria should apply to.
  FilterCriteria<M> map<M>(T Function(M) m) => MapCriteria<M, T>(m, accepts);

  FilterCriteria<T> not() => NotCriteria(this);

  FilterCriteria<T> and(FilterCriteria<T> other) => AndCriteria([this, other]);

  FilterCriteria<T> operator &(FilterCriteria<T> other) => and(other);

  FilterCriteria<T> or(FilterCriteria<T> other) => OrCriteria([this, other]);

  FilterCriteria<T> operator |(FilterCriteria<T> other) => or(other);

  FilterCriteria<T> xor(FilterCriteria<T> other) => XOrCriteria([this, other]);

  /// Convert this criteria to a list of criteria.
  Iterable<FilterCriteria<T>> get only => [this];

  Iterable<T> meetCriteria(Iterable<T> t) => t.where(this);

  /// Returns true if at least one of the provided items is accepted
  bool acceptsAtLeastOne(Iterable<T> t) => t.map(accepts).contains(true);

  /// Returns true when all of the provided items are accepted.
  bool acceptsOnlyAll(Iterable<T> t) => !t.map(accepts).contains(false);
}
