

abstract class ReviewState  {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewSuccess extends ReviewState {
  final String message;
  const ReviewSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ReviewFailure extends ReviewState {
  final String error;
  const ReviewFailure(this.error);

  @override
  List<Object> get props => [error];
}
