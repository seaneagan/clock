clock [![pub package](http://img.shields.io/pub/v/clock.svg)](https://pub.dartlang.org/packages/clock) [![Build Status](https://drone.io/github.com/seaneagan/clock/status.png)](https://drone.io/github.com/seaneagan/clock/latest)
=====

The `clock` package provides testable replacements for the system clock APIs
(`new DateTime.now()` and `new Stopwatch()`).

##Usage

Access `now` and `getStopwatch()` instead of `new DateTime.now()` and 
`new Stopwatch()`.  You may want to import with a prefix:

```dart
import 'package:clock/clock.dart' as clock;

int get currentYear => clock.now.year;

Duration timeAction(action()) {
  var stopwatch = clock.getStopwatch()..start();
  action();
  return stopwatch.elapsed;
}
```

Then use `withClock(new Clock(...), () { /* test code */ });` to make your 
tests deterministic:

```dart
import 'package:clock/clock.dart';
import 'package:unittest/unittest.dart';

import 'time_utils.dart'; // What we're testing.

main() {
  group('time utils', () {
  
    test('currentYear should return the current year', () {
      withClock(new Clock(initialTime: new DateTime(2014, 3, 6)), () {
        expect(currentYear, 2014);
      });
    });

    test('timeAction should time the action', () {
      var elapsed = Duration.ZERO;
      
      withClock(new Clock(elapsed: () => elapsed), () {
        expect(timeAction(() {
          elapsed += const Duration(seconds: 5);
        }), const Duration(seconds: 5));
      });
    });
  });
}
```
