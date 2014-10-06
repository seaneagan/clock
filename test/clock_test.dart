
library clock.test;

import 'package:unittest/unittest.dart';
import 'package:mock/mock.dart';
import 'package:clock/clock.dart';
import 'package:clock/src/fake_stopwatch.dart';

main() {
  group('withClock', () {
    
    var mockClock;
    setUp(() {
      mockClock = new MockClock();
      mockClock.when(callsTo('get now')).alwaysReturn(new DateTime(2014));
      mockClock.when(callsTo('getStopwatch')).alwaysReturn(new FakeStopwatch(() => 0, 1000));
    });
    
    test('overrides now', () {
      withClock(mockClock, () {
        expect(now, new DateTime(2014));
      });
    });
    
    test('overrides getStopwatch', () {
      withClock(mockClock, () {
        expect(getStopwatch(), new isInstanceOf<FakeStopwatch>());
      });
    });

    test('isFinal prevents nested overriding', () {
      
      bool wasCalled = false;
      
      withClock(mockClock, () {
        expect(() {
          wasCalled = true;
          withClock(mockClock, () {});
        }, throws);
      }, isFinal: true);
      expect(wasCalled, isTrue);
    });
  });
  
}

@proxy
class MockClock extends Mock implements Clock {}
