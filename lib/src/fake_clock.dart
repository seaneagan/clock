
part of clock;

typedef Duration _Elapsed();

class RelativeClock extends Clock {
  
  final DateTime _initialTime;
  final _Elapsed _elapsed;
  final int _frequency;
  
  RelativeClock(this._initialTime, Duration elapsed(), {
    int frequency: 1000000
  }) 
      : _elapsed = elapsed,
        _frequency = frequency,
        super();
  
  DateTime get now => _initialTime.add(_elapsed());
  Stopwatch getStopwatch() => new FakeStopwatch(() => 
      _elapsed().inMicroseconds * _frequency ~/ 1000000, _frequency);
}
