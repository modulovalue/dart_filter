import 'package:dart_filter/dart_filter.dart';

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

void main(List<String> arguments) {
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

      /// Only Females
      AnonymousCriteria((Person p) => p.sex == Sex.female),

      /// Name contains an S
      if (withAnSOnly)
        const ContainsFilter("s", true).map((Person p) => p.name),
    ]),
  );

  print(onlyFemaleAdultsWithMaybeAnS);
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
