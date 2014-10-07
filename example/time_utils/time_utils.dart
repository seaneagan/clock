
library time_utils;

import 'package:clock/clock.dart' as clock;

int get currentYear => clock.now.year;

Duration timeAction(action()) {
  var stopwatch = clock.getStopwatch()..start();
  action();
  return stopwatch.elapsed;
}
