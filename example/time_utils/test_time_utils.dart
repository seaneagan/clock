
library time_utils.test;

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
