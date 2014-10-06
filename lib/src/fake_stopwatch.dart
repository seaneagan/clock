/**
 * Returns the current test time in microseconds.
 */
typedef int _Now();

/**
 * A [Stopwatch] implementation that gets the current time in microseconds
 * via a user-supplied function.
 */
class FakeStopwatch implements Stopwatch {
  _Now _now;
  int frequency;
  int _start;
  int _stop;

  FakeStopwatch(int now(), int this.frequency)
      : _now = now,
        _start = null,
        _stop = null;

  void start() {
    if (isRunning) return;
    if (_start == null) {
      _start = _now();
    } else {
      _start = _now() - (_stop - _start);
      _stop = null;
    }
  }

  void stop() {
    if (!isRunning) return;
    _stop = _now();
  }

  void reset() {
    if (_start == null) return;
    _start = _now();
    if (_stop != null) {
      _stop = _start;
    }
  }

  int get elapsedTicks {
    if (_start == null) {
      return 0;
    }
    return (_stop == null) ? (_now() - _start) : (_stop - _start);
  }

  Duration get elapsed => new Duration(microseconds: elapsedMicroseconds);

  int get elapsedMicroseconds => (elapsedTicks * 1000000) ~/ frequency;

  int get elapsedMilliseconds => (elapsedTicks * 1000) ~/ frequency;

  bool get isRunning => _start != null && _stop == null;
}