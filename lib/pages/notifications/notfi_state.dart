

abstract class NotificationsState  {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final dynamic notifications;
  const NotificationsLoaded(this.notifications);

  @override
  List<Object> get props => [notifications];
}

class NotificationsError extends NotificationsState {
  final String message;
  const NotificationsError(this.message);

  @override
  List<Object> get props => [message];
}
