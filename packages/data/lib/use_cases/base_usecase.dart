abstract class UseCaseParams<Params, Output> {
  Output call(Params params);

  void dispose();
}

abstract class UseCase<Output> {
  Output call();

  void dispose();
}
