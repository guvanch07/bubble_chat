// {name: Foo, age: 20, address: Foo Street, post_code: 1234}
extension Merge<K, V> on Map<K, V> {
  Map<K, V> operator |(Map<K, V> other) => {...this}..addEntries(other.entries);
}

extension DetailedWhere<K, V> on Map<K, V> {
  Map<K, V> where(bool Function(K key, V value) f) => Map<K, V>.fromEntries(
        entries.where((entery) => f(entery.key, entery.value)),
      );

  Map<K, V> whereKey(bool Function(K key) f) => {
        ...where((key, value) => f(key)),
      };

  Map<K, V> whereValue(bool Function(V value) f) => {
        ...where((key, value) => f(value)),
      };
// {foofoo: 22, barbar: 30, bazbaz: 40}
  Map<R, V> mappedKeys<R>(R Function(K) f) => map(
        (key, value) => MapEntry(f(key), value),
      );
  // {foo: 44, bar: 60, baz: 80} x2 just values
  Map<K, R> mappedValues<R>(R Function(V) f) => map(
        (key, value) => MapEntry(key, f(value)),
      );
}

extension IterationWithIndex<T> on Iterable<T> {
  Iterable<E> mapWithIndex<E>(E Function(int index, T value) f) =>
      Iterable.generate(length).map((i) => f(i, elementAt(i)));
}
