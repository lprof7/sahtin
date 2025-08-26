class Either<L, R> {
  final L? left;
  final R? right;
  final bool isLeft;

  Either.left(this.left) : right = null, isLeft = true;
  Either.right(this.right) : left = null, isLeft = false;
}
