part of clock;

typedef Duration _Elapsed();

class _RelativeClock implements _SystemClock {
  final DateTime _initialTime;
  final _Elapsed _elapsed;
  final int _frequency;

  _RelativeClock(
      {DateTime initialTime, Duration elapsed(), int frequency: 1000000})
      : _initialTime =
            initialTime == null ? _zonedClock.value.now : initialTime,
        _elapsed = elapsed == null ? (() => Duration.ZERO) : elapsed,
        _frequency = frequency;

  DateTime get now => _initialTime.add(_elapsed());
  Stopwatch getStopwatch() => new FakeStopwatch(
      () => _elapsed().inMicroseconds * _frequency ~/ 1000000, _frequency);
}
