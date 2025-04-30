class DataState<T> {
  final StateType state;
  late final T? data;
  final String? error;

  DataState({required this.state, this.data, this.error});
}

enum StateType { loading, success, error, empty }
