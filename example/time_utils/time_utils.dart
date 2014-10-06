
library time_utils;

import 'package:clock/clock.dart' as clock;

DateTime startOfDay([DateTime time]) {
  if(time == null) time = clock.now;
  return new DateTime(time.year, time.month, time.day);
}

Duration timeAction(action()) {
  var stopwatch = clock.getStopwatch()..start();
  action();
  return stopwatch.elapsed;
}
