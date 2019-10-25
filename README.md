# dart_filter
High Level Filter Queries for Dart, loosely based of the [Filter pattern](https://www.tutorialspoint.com/design_pattern/filter_pattern.htm)

[![Travis CI](https://img.shields.io/travis/com/modulovalue/dart_filter/master?style=flat-square&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAXCAYAAAARIY8tAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAhGVYSWZNTQAqAAAACAAFARIAAwAAAAEAAQAAARoABQAAAAEAAABKARsABQAAAAEAAABSASgAAwAAAAEAAgAAh2kABAAAAAEAAABaAAAAAAAAAEgAAAABAAAASAAAAAEAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAGKADAAQAAAABAAAAFwAAAACTX49/AAAACXBIWXMAAAsTAAALEwEAmpwYAAACZmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS40LjAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iPgogICAgICAgICA8dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICAgICA8dGlmZjpSZXNvbHV0aW9uVW5pdD4yPC90aWZmOlJlc29sdXRpb25Vbml0PgogICAgICAgICA8ZXhpZjpDb2xvclNwYWNlPjE8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjMzPC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxZRGltZW5zaW9uPjMyPC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CgC+O6sAAAdrSURBVEgNfVV7bFPXGf/de339jO3YiY0TkiYhBEISSLBJA1lSCJRswNRtvCYx0LZqDdUonVqqqUKa6lVjE221dq2KRrauU1XoCAPGI2RQCiFKAiPkRYgNIQ9iGzuOE8fxI7bvte/dsdfH/ph2pHPPud/53r/vO4fC/xhNTRa2ubmXJ0dUfcPTjS/8uGFPrklXo1DKcgmNicd5j9cb6LvU1t9y4kTbRUKLNzU1EZnmlMz/H1brLumXHCvOnn6jbXLsEzEZbxUF8YoY5y+nZ5Lsk3yb6HGdFFsvHuki/OtSMsePN7Ffyn69UF/vyOYbLySbum6+daa2vly7EIomBvtGMXG+n5YzEgoMjXgoKuo3rhDXbaoQNDo123P7AX79m7/ta23t/jRlZP/+byJh/ssA09vbmyD/q//V/d7VqqoiNc/xnMvpY+dcftrecotSxCiKcYWp8SEPlbk8i5bolUyGQsoZDZmMuap4+4NxX88Hf7jw0GKxsB6PR0jp/ioCWhRFUBSl6Lj+zhdr15bWBAIhXqfXsIM9I8jNyQSfocLQhdsI2dyoPvQcVMkknJPTWLWmBAuRGC+Xy1i73fXYUnOgluj1kJlyPkmTD1parBKiXDj0yq4fWapLambnQhzHJ1nP1BymPH6oVXLkG7RgGQoJjkdutgZZmSrM+ubhdM2CJ7wzs0HObF5S+M5bL76U0jk8bE1nR2K1Wundu60coa3Z/GzVa0IiiUc2p0QllyAW4zDjDSDJJzA1M4/p1lFQd90Yf9mLpcRIYCYIx0MXso1a+PxhVqtViRZLcRPRdbO83HqVZIVi2tvbxTetz7/45+ZftFRVFhnD4aiwsBCnVz+9HFK5FCGiWCTpSETjGO6fQFgvganUBC4SRTgURWnVEiwrL0QkuEAAolFWmq964Wdb9xUXL6Zr1m69IUmFs2rVU1uWlOTJiKtxEpeMIsg4HNPw+8NQEe8CBHomwqNq/wakcpqK0hvhoM7JSnkOkfZCIBiyEChWynD5hbnSlRUFjYT1aNrAfDAa4xeiuG930v0ExJlpIkS8WWxUw6hXIhyJgFmIg+YFREQBMk0GaOKJQiUXpyZnqfbOUUTjPEwGDUqWztLV5iLEolw05UvawIx33v7Xk104dnIE1QIPP2kXEzkdiCRwV8pi9EkIDTM8pAEeVyCibqMRw7McFmVIKUuRHnq1DDRpkSttg1gIQXx2WwEpz3k7URH7qkzNjTu3XzdTjHbtdFDsVTHU8j4fqIPPIKIkjS3Q8BPAU9WkYiVwTwdg0KmxmFSWlGWgUipB0zQ8Dg+6bg3zjhjJ1qk7b5zC+JvpUnq/vPbneVJp44RJk9RUL6VpXQae2vMtjMzHwUp1WL3MhBydBj7fHMIkVSsKTFhelAOPn8PtYTcWaVnIFQro9Fq4OZ7ixjyUScOUdeblddMwmze6ZcwP52NRTHFJKj8nGxs2WGAyGbDgn8OBD/+BOJfA4CMnTnTZ0W134XznEBIJAR23B3Dj1iBkMjlokotYNAaHNyAwMR4aTvgnFAkng7rlvm9/4aNzNy3b/FgUkzFSbkU5WRQrYVCw2IC9G8rAJxJ4/9IdvPSdNdi2rgyHL/aiJl+PenMJ1luKoVWrIQhJ9Nkn0DHqSVQoWEbuCFy+OtBzjoHtMbcDed81VhjrVzWuTnYPjNEd9x8jNB+i/MEw3KRb//J5P0oXabF3y1rk5RigS8bx+vkeZNMiIgQb25gL13pH0DXsErfWrRCXRHhG+Nw5cgneC+kq8prV7sIxH2Lz4cTqYqOgUCrZ0Sez1ATpYoZcDztrS1FXWQJyf8A1NYMGSylyDZloHxjDOLlOZATo0vxs0ahiwdsmk9muBXaiXOnGMJA2kBkXTSuHJLh366Lv9Tqm2fH2a4dphlZG4xwkpB+0aiUSgohR51Qaj6I8AxrzK1Gzcik4kj6aokVthpKytrR+VvNuX2WFurjs0WLWSMo03Zjoq9ZP2n9VAO+ewk503jlyvXvAptNmIEMpTyhkUtKtQTzsfYDEiAvskxk47j6Ewz0NCcFJIZOJBr0GD8adwQ+OHH/V972SVtsvC3BvvX7yPwaUypyNo9GXtaSphpXi9RTxJ4d+++qAbTxKlEtomuKnZ+bQc6wTvgcxeO0R3P9oEOOPHKBoWlDJpZzHN0cd/dO5t4no1DWt0IVgFLWjsYMVyC9mUFlZeDCmeqXgTFA+GfSPX/M7rxBGx8Ajv62qrOD7uUa9NGdRdly5TEeFh2ygI34xb2eVUF1XlZBKGMo1PccebT77x1NnLx8mcuI2Lmv3+vOxBqhE9f0i5WeEBny6ZtPpkfU7xJ9W1+5N/f9+1y5FaiVjw8kPrUMPO06Kc7bL4tTgedHdfy69d975u3jmo99Ft2zZnFKMGzesaTxrLTWNg8/8QDxTvfkmIcvSxDvJaMd4JImP73afEMkrR50+HSXvROqtaN9zwFr//L7tO9asWPqcyaArJSmTTs8GpuyP3e3vHvsk5eG9lpYWpqFhdzJ1/5Nx9bS5/uMYkg5yFv830J5szSotYXoAAAAASUVORK5CYII=)](https://travis-ci.com/modulovalue/dart_filter) [![Codecov](https://img.shields.io/codecov/c/github/modulovalue/dart_filter/master?style=flat-square&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAAAXNSR0IArs4c6QAAAKJlWElmTU0AKgAAAAgABQESAAMAAAABAAEAAAEaAAUAAAABAAAASgEbAAUAAAABAAAAUgExAAIAAAAeAAAAWodpAAQAAAABAAAAeAAAAAAAAABIAAAAAQAAAEgAAAABQWRvYmUgUGhvdG9zaG9wIENTNSBNYWNpbnRvc2gAAAOgAQADAAAAAQABAACgAgAEAAAAAQAAAB6gAwAEAAAAAQAAAB4AAAAA/yGTGQAAAAlwSFlzAAALEwAACxMBAJqcGAAABBFpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDUuNC4wIj4KICAgPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgICAgICAgICAgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iCiAgICAgICAgICAgIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIj4KICAgICAgICAgPHhtcE1NOkluc3RhbmNlSUQ+eG1wLmlpZDo0OTYwQURFNUFBMTcxMUU0QTM3MkVDM0E3Q0VGQzJFQTwveG1wTU06SW5zdGFuY2VJRD4KICAgICAgICAgPHhtcE1NOkRlcml2ZWRGcm9tIHJkZjpwYXJzZVR5cGU9IlJlc291cmNlIj4KICAgICAgICAgICAgPHN0UmVmOmluc3RhbmNlSUQ+eG1wLmlpZDo0OTYwQURFM0FBMTcxMUU0QTM3MkVDM0E3Q0VGQzJFQTwvc3RSZWY6aW5z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)](https://codecov.io/gh/modulovalue/dart_filter) [![License](https://img.shields.io/github/license/modulovalue/dart_filter?style=flat-square&logo=github)](https://github.com/modulovalue/dart_filter/blob/master/LICENSE) [![License](https://img.shields.io/pub/v/dart_filter.svg?style=flat-square&logo=data:image/png;base64,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)](https://pub.dartlang.org/packages/dart_filter) [![Github Stars](https://img.shields.io/github/stars/modulovalue/dart_filter?style=flat-square&logo=github)](https://github.com/modulovalue/dart_filter)

[![Twitter Follow](https://img.shields.io/twitter/follow/modulovalue?style=social&logo=twitter)](https://twitter.com/modulovalue) [![Twitter Follow](https://img.shields.io/github/followers/modulovalue?style=social&logo=github)](https://github.com/modulovalue)

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

Each FilterCriteria overrides the call method and therefore acts as a function that you can pass to higher-order functions like `.where`.

## All available FilterCriteria:

- **AcceptAllCriteria**: accepts everything.
- **AcceptNoneCriteria**: accepts nothing.
- **AndCriteria (.and or &)**: accepts an item only if all criteria are met.
- **OrCriteria (.or or |)**: accepts an item only if at least one of the provided criteria is met.
- **XOrCriteria (.xor)**: accepts an item only if one of the provided criteria is met.
- **NotCriteria (.not)**: negates the provided criteria.
- **MapCriteria (.map)**: use this to map a criteria to a different type.
- **EqualsCriteria**: accepts an item only if it is equal (==) to the provided value.
- **AnonymousCriteria**: use this to quickly prototype a custom criteria without subclassing FilterCriteria.

There are also some criteria for Lists of Strings: 
- **StartsWithFilter**: accepts only Strings that start with the provided string.
- **EndsWithFilter**: accepts only Strings that end with the provided string.
- **ContainsFilter**: accepts only Strings that contain the provided string.
