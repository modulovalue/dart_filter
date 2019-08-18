import 'package:test/test.dart';
import 'package:dart_filter/dart_filter.dart';

void main() {
    group("generic filters", () {
        const all = AcceptAllCriteria<bool>();
        const none = AcceptNoneCriteria<bool>();

        test("$AcceptAllCriteria", () {
            expect(const AcceptAllCriteria<String>().accepts(null), true);
            expect(const AcceptAllCriteria<String>(), const AcceptAllCriteria<String>());
            expect(const AcceptAllCriteria<String>(), isNot(const AcceptNoneCriteria<String>()));
            expect(const AcceptAllCriteria<String>().hashCode, const AcceptAllCriteria<String>().hashCode);
        });

        test("$AcceptNoneCriteria", () {
            expect(const AcceptNoneCriteria<String>().accepts(null), false);
            expect(const AcceptNoneCriteria<String>(), const AcceptNoneCriteria<String>());
            expect(const AcceptNoneCriteria<String>(), isNot(const AcceptAllCriteria<String>()));
            expect(const AcceptNoneCriteria<String>().hashCode, const AcceptNoneCriteria<String>().hashCode);
        });

        test("$AndCriteria", () {
            expect(const AndCriteria([all, none, none]).accepts(null), false);
            expect(const AndCriteria([all, all, none]).accepts(null), false);
            expect(const AndCriteria([none, none, none]).accepts(null), false);
            expect(const AndCriteria([all, all, all]).accepts(null), true);
            expect(const AndCriteria<String>([]).accepts(null), true);
            expect(const AndCriteria<String>([], defaultCriteria: AcceptNoneCriteria()).accepts(null), false);
            // ignore: prefer_const_constructors
            expect(() => AndCriteria<String>(null).accepts(null), throwsA(const TypeMatcher<AssertionError>()));
        });

        test("$OrCriteria", () {
            expect(const OrCriteria([all, none, none]).accepts(null), true);
            expect(const OrCriteria([all, all, none]).accepts(null), true);
            expect(const OrCriteria([none, none, none]).accepts(null), false);
            expect(const OrCriteria([all, all, all]).accepts(null), true);
            expect(const OrCriteria([all, all, all]).accepts(null), true);
            expect(const OrCriteria<String>([]).accepts(null), false);
            expect(const OrCriteria<String>([], defaultCriteria: AcceptAllCriteria()).accepts(null), true);
            // ignore: prefer_const_constructors
            expect(() => OrCriteria<String>(null).accepts(null), throwsA(const TypeMatcher<AssertionError>()));
        });

        test("$XOrCriteria", () {
            expect(const XOrCriteria([all, none, none]).accepts(null), true);
            expect(const XOrCriteria([all, all, none]).accepts(null), false);
            expect(const XOrCriteria([none, none, none]).accepts(null), false);
            expect(const XOrCriteria<String>([]).accepts(null), false);
            expect(const XOrCriteria<String>([], defaultCriteria: AcceptAllCriteria()).accepts(null), true);
            // ignore: prefer_const_constructors
            expect(() => XOrCriteria<String>(null).accepts(null), throwsA(const TypeMatcher<AssertionError>()));
        });

        test("$NotCriteria", () {
            expect(const NotCriteria(all).accepts(false), false);
            expect(const NotCriteria(all).accepts(true), false);
            expect(const NotCriteria(none).accepts(false), true);
            expect(const NotCriteria(none).accepts(true), true);
            // ignore: prefer_const_constructors
            expect(() => NotCriteria<String>(null).accepts(null), throwsA(const TypeMatcher<AssertionError>()));
        });

        test("$AnonymousCriteria", () {
            expect(AnonymousCriteria<bool>((dynamic a) => true).accepts(false), true);
            expect(AnonymousCriteria<bool>((dynamic a) => true).accepts(true), true);
            expect(AnonymousCriteria<bool>((dynamic a) => false).accepts(false), false);
            expect(AnonymousCriteria<bool>((dynamic a) => false).accepts(true), false);
            // ignore: prefer_const_constructors
            expect(() => AnonymousCriteria<String>(null).accepts(null), throwsA(const TypeMatcher<AssertionError>()));
        });

        test("$MapCriteria", () {
            expect(MapCriteria<String, double>((String a) => double.tryParse(a) ?? 0.0, AnonymousCriteria<double>((double a) => a >= 0.5).accepts).accepts("0.1"), false);
            expect(MapCriteria<String, double>((String a) => double.tryParse(a) ?? 0.0, AnonymousCriteria<double>((double a) => a >= 0.5).accepts).accepts("0.5"), true);
            expect(MapCriteria<String, double>((String a) => double.tryParse(a) ?? 0.0, AnonymousCriteria<double>((double a) => a >= 0.5).accepts).accepts("1.0"), true);
            expect(() => MapCriteria<String, double>((String a) => double.tryParse(a) ?? 0.0, null), throwsA(const TypeMatcher<AssertionError>()));
        });

        test("$EqualsCriteria", () {
            expect(const EqualsCriteria<String>("a").accepts("b"), false);
            expect(const EqualsCriteria<String>("a").accepts("a"), true);

            expect(const EqualsCriteria<String>("a"), isNot(const EqualsCriteria<String>("b")));
            expect(const EqualsCriteria<String>("a"), const EqualsCriteria<String>("a"));
            expect(const EqualsCriteria<String>("a").hashCode, const EqualsCriteria<String>("a").hashCode);
            expect(const EqualsCriteria<String>("a").hashCode, isNot(const EqualsCriteria<String>("b").hashCode));
        });
    });

    group("$FilterCriteria", () {
        test("map", () {
            expect(const StartsWithFilter("0.123", true).map<double>((double d) => d.toString()).accepts(1.123), false);
        });

        test("only", () {
            expect(const StartsWithFilter("0.123", true).only.length, 1);
            expect(const StartsWithFilter("0.123", true).only.first, const TypeMatcher<StartsWithFilter>());
        });

        test("acceptsOne", () {
            expect(const StartsWithFilter("a", false).acceptsAtLeastOne(["a", "b", "c"]), true);
            expect(const StartsWithFilter("a", false).acceptsAtLeastOne(["x", "b", "c"]), false);
            expect(const StartsWithFilter("a", false).acceptsAtLeastOne(["a", "a", "a"]), true);
        });

        test("acceptsOnlyAll", () {
            expect(const StartsWithFilter("a", false).acceptsOnlyAll(["a", "aa", "aaa"]), true);
            expect(const StartsWithFilter("a", false).acceptsOnlyAll(["a", "aa", "b"]), false);
        });
    });

    group("String filters", () {
        test("$StartsWithFilter", () {
            expect(const StartsWithFilter("B", true).accepts("bitcoin"), true);
            expect(const StartsWithFilter("B", true).accepts("Bitcoin"), true);
            expect(const StartsWithFilter("b", true).accepts("Bitcoin"), true);
            expect(const StartsWithFilter("b", true).accepts("bitcoin"), true);
            expect(const StartsWithFilter("b", true).accepts("titcoin"), false);
            expect(const StartsWithFilter("B", false).accepts("Bitcoin"), true);
            expect(const StartsWithFilter("B", false).accepts("bitcoin"), false);
            expect(const StartsWithFilter("b", false).accepts("bitcoin"), true);
            expect(const StartsWithFilter("b", false).accepts("Bitcoin"), false);
            expect(const StartsWithFilter("a", true), isNot(const StartsWithFilter("b", true)));
            expect(const StartsWithFilter("a", true), isNot(const StartsWithFilter("a", false)));
            expect(const StartsWithFilter("a", true), const StartsWithFilter("a", true));
            expect(const StartsWithFilter("a", true).hashCode, const StartsWithFilter("a", true).hashCode);
            expect(const StartsWithFilter("a", true).hashCode, isNot(const StartsWithFilter("b", true).hashCode));
            expect(const StartsWithFilter("a", true).hashCode, isNot(const StartsWithFilter("a", false).hashCode));
        });

        test("$EndsWithFilter", () {
            expect(const EndsWithFilter("abc", true).accepts("abc"), true);
            expect(const EndsWithFilter("ABC", true).accepts("abc"), true);
            expect(const EndsWithFilter("ABC", false).accepts("abc"), false);
            expect(const EndsWithFilter("ABC", false).accepts("ABC"), true);
            expect(const EndsWithFilter("n", true).accepts("bitcoin"), true);
            expect(const EndsWithFilter("n", true).accepts("Bitcoin"), true);
            expect(const EndsWithFilter("N", true).accepts("Bitcoin"), true);
            expect(const EndsWithFilter("N", true).accepts("BitcoiN"), true);
            expect(const EndsWithFilter("N", true).accepts("BitcoiA"), false);
            expect(const EndsWithFilter("N", false).accepts("bitcoin"), false);
            expect(const EndsWithFilter("N", false).accepts("bitcoiN"), true);
            expect(const EndsWithFilter("a", true), isNot(const EndsWithFilter("b", true)));
            expect(const EndsWithFilter("a", true), isNot(const EndsWithFilter("a", false)));
            expect(const EndsWithFilter("a", true), const EndsWithFilter("a", true));
            expect(const EndsWithFilter("a", true).hashCode, const EndsWithFilter("a", true).hashCode);
            expect(const EndsWithFilter("a", true).hashCode, isNot(const EndsWithFilter("b", true).hashCode));
            expect(const EndsWithFilter("a", true).hashCode, isNot(const EndsWithFilter("a", false).hashCode));
        });

        test("$ContainsFilter", () {
            expect(const ContainsFilter("c", true).accepts("bitCoin"), true);
            expect(const ContainsFilter("c", true).accepts("bitcoin"), true);
            expect(const ContainsFilter("C", true).accepts("bitcoin"), true);
            expect(const ContainsFilter("C", true).accepts("bitCoin"), true);
            expect(const ContainsFilter("c", false).accepts("Bitcoin"), true);
            expect(const ContainsFilter("c", false).accepts("BitCoin"), false);
            expect(const ContainsFilter("C", false).accepts("bitCoin"), true);
            expect(const ContainsFilter("C", false).accepts("bitcoin"), false);
            expect(const ContainsFilter("a", true), isNot(const ContainsFilter("b", true)));
            expect(const ContainsFilter("a", true), isNot(const ContainsFilter("a", false)));
            expect(const ContainsFilter("a", true), const ContainsFilter("a", true));
            expect(const ContainsFilter("a", true).hashCode, const ContainsFilter("a", true).hashCode);
            expect(const ContainsFilter("a", true).hashCode, isNot(const ContainsFilter("b", true).hashCode));
            expect(const ContainsFilter("a", true).hashCode, isNot(const ContainsFilter("a", false).hashCode));
        });
    });
}