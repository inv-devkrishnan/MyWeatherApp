abstract interface class UseCase<SuccessType> {
  Future<SuccessType> call();
}
