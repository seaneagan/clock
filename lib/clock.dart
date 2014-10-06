
library clock;

import 'src/zoned_value.dart';
import 'src/fake_stopwatch.dart';

part 'src/fake_clock.dart';

/// Returns the current time.
/// 
/// By default this just returns `new DateTime.now()`, but see [withClock].
DateTime get now => _zonedClock.value.now;

/// Returns a new Stopwatch.
/// 
/// By default this just returns `new Stopwatch()`, but see [withClock].
Stopwatch getStopwatch() => _zonedClock.value.getStopwatch();

/// Overrides the [Clock] used by [now] and [getStopwatch].
/// 
/// This runs the [callback] in a [Zone] in which references to [now] and 
/// [getStopwatch] forward to [clock] instead of the system clock.
/// 
/// This can be used for testing by passing a fake [clock] and a test 
/// [callback].
/// 
/// Set [isFinal] to `true` to prevent any nested overriding of the [clock].
void withClock(Clock clock, callback(), {isFinal: false}) => 
    _zonedClock.withValue(clock, callback, isFinal: isFinal);

var _zonedClock = new ZonedValue(new _SystemClock());

/// Tells time.
abstract class Clock {
  
  Clock();
  
  factory Clock.relative(DateTime initialTime, Duration elapsed()) = RelativeClock;
  
  DateTime get now;
  Stopwatch getStopwatch();
}

class _SystemClock implements Clock {
  DateTime get now => new DateTime.now();
  Stopwatch getStopwatch() => new Stopwatch();
}
