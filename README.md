# dart_filter
High Level Filter Queries for Dart, loosely based of the [Filter pattern](https://www.tutorialspoint.com/design_pattern/filter_pattern.htm)

[On pub.dev](https://pub.dev/packages/dart_filter#-readme-tab-)

dart_filter lets you easily filter dart Lists and Iterables. New requirements oftentimes 
break naive filtering solutions. dart_filter is here to fix that.

Example:
```dart
... 
people.where(
  AndCriteria([
    /// Only adults
    const OnlyAdultsFilter().map((Person p) => p.age),

    /// Only females
    AnonymousCriteria((Person p) => p.sex == Sex.female),

    /// Only names that contain an s
    if (withAnSOnly)
      const ContainsFilter("s", true).map((Person p) => p.name),
  ]),
);

class OnlyAdultsFilter extends FilterCriteria<int> {
  const OnlyAdultsFilter();

  @override
  bool accepts(int t) => t >= 18;
}
```

Each FilterCriteria overrides the call method and therefore acts as a function that you can pass to higher order functions like `.where`.

## All available FilterCriteria:

- AcceptAllCriteria: accepts all items.
- AcceptNoneCriteria: accepts no items.
- AndCriteria (.and or &): accepts an item only if all criteria are met.
- OrCriteria (.or or |): accepts an item only if one of the provided criteria is met.
- XOrCriteria (.xor): accepts an item only if one of the provided criteria is met.
- NotCriteria (.not): negates the provided criteria.
- MapCriteria (.map): use this to map a criteria to a different type.
- EqualsCriteria: accepts an item only if it is equal (==) to the provided value.
- AnonymousCriteria: use this to quickly prototype a custom criteria without subclassing FilterCriteria.

There are also some criteria for Lists of Strings: 
- StartsWithFilter: accepts only Strings that start with the provided string.
- EndsWithFilter: accepts only Strings that end with the provided string.
- ContainsFilter: accepts only Strings that contain the provided string.
