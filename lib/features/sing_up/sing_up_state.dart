abstract class SingUpState {}

class SingUpInitialState extends SingUpState {}

class SingUpLoadingState extends SingUpState {}

class SingUpSuccessState extends SingUpState {}

class SingUpErrorState extends SingUpState {
  final String message;

  SingUpErrorState({required this.message});
}
