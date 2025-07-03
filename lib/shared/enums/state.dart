enum State {
  initial,
  protect,
  loading,
  success,
  error;

  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isError => this == error;
  bool get isProtected => this == protect;
}
