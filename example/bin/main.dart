import 'package:dart_filter/dart_filter.dart';

void test() {
  var a = () => 5;

  final callMe1 = (int Function() fn) => callMe(a);
  final callMe2 = (int Function() fn) => callMe(() => a());
  print(callMe1(a));
  print(callMe2(a));
  a = () => 6;
  print(callMe1(a));
  print(callMe2(a));

}

int callMe(int Function() fn) {
  return fn();
}

void main(List<String> arguments) {

  test();
  const people = [
    Person("Alice", 5, Sex.female),
    Person("Bob", 20, Sex.male),
    Person("John", 50, Sex.male),
    Person("Jane", 100, Sex.female),
    Person("Susan", 70, Sex.female),
  ];

  filterStrings(people.map((a) => a.name));

  const withAnSOnly = true;

  final onlyFemaleAdultsWithMaybeAnS = people.where(
    AndCriteria([
      /// Only Adults
      const OnlyAdultsFilter().map((Person p) => p.age),

      /// Only Female
      AnonymousCriteria((Person p) => p.sex == Sex.female),

      /// Name contains an S
      if (withAnSOnly)
        const ContainsFilter("s", true).map((Person p) => p.name),
    ]),
  );

  final onlyFemaleAdultsWithMaybeAnSNaive = people.where((p) {
    final baseQuery = p.sex == Sex.female && p.age >= 18;

    if (withAnSOnly) {
      return baseQuery && p.name.contains("s");
    } else {
      return baseQuery;
    };
  });

  print(onlyFemaleAdultsWithMaybeAnS);
  print(onlyFemaleAdultsWithMaybeAnSNaive);
}

void filterStrings(Iterable<String> names) {
  final listWithAnE = names.where(const ContainsFilter("e", true));
  print(listWithAnE);

  final startsWithAnA = names.where(const StartsWithFilter("a", true));
  print(startsWithAnA);

  final endsWithAnN = names.where(const EndsWithFilter("n", true));
  print(endsWithAnN);

  final doesntEndWithAnN = names.where(const EndsWithFilter("n", true).not());
  print(doesntEndWithAnN);

  final startsWithJOrEndsWithE = names
      .where(const StartsWithFilter("j", true) | EndsWithFilter("e", true));
  print(startsWithJOrEndsWithE);
}

class Person {
  final String name;
  final int age;
  final Sex sex;

  const Person(this.name, this.age, this.sex);

  @override
  String toString() => 'Person{age: $age, name: $name}';
}

enum Sex {
  male,
  female,
}

class OnlyAdultsFilter extends FilterCriteria<int> {
  const OnlyAdultsFilter();

  @override
  bool accepts(int t) => t >= 18;
}
