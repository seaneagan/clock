
library clock.testing.test;

import 'package:unittest/unittest.dart';
import 'package:clock/clock.dart';

main() {
  group('Clock.relative', () {

    var initialTime = new DateTime(2014);
    var elapsed = new Duration(seconds: 5);
    Clock fakeClock;
    
    setUp(() {
      fakeClock = new Clock(initialTime: initialTime, elapsed: () => elapsed);
    });
    
    group('FakeClock', () {
      test('calculates now correctly', () {
        expect(fakeClock.now, initialTime.add(elapsed));
      });
      
      test('calculates stopwatch times correctly', () {
        var stopwatch = fakeClock.getStopwatch();
        stopwatch.start();
        var stopwatchLength = new Duration(seconds: 2);
        elapsed += stopwatchLength;
        expect(stopwatch.elapsed, stopwatchLength);
      });
    });
  });
  
}
