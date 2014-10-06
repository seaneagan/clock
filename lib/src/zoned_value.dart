
library zoned_value;

import 'dart:async';

/// A simple way to expose a default value that can be overridden within zones.
class ZonedValue<T> {
  
  final T _rootValue;
  final _valueKey = new Object();
  final _finalKey = new Object();
  
  ZonedValue(T rootValue) : _rootValue = rootValue;
  
  void withValue(T value, f(), {
      bool isFinal: false}
  ) {
    if(this.isFinal) {
      throw new StateError('Cannot override final zoned value');
    }
    runZoned(f, zoneValues: {
      _valueKey: value,
      _finalKey: isFinal
    });
  }
  
  bool get isFinal {
    var parentIsFinal = Zone.current[_finalKey];
    return parentIsFinal != null && parentIsFinal;
  }
  
  T get value {
    // TODO: Allow null values when http://dartbug.com/21247 is fixed.
    var v = Zone.current[_valueKey];
    return v != null ? v : _rootValue;
  }
}
