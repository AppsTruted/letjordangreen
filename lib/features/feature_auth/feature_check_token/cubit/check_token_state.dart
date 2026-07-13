part of 'check_token_cubit.dart';

abstract class CheckTokenState extends Equatable {

}

class CheckTokenInitial extends CheckTokenState {
  @override
  List<Object> get props => [];
}

class CheckTokenLoading extends CheckTokenState {
 @override
 List<Object> get props => [];
}

class CheckTokenDone extends CheckTokenState {
 final CheckTokenModel checkToken;

 CheckTokenDone({required this.checkToken});

  @override
 List<Object> get props => [checkToken];
}


class CheckTokenFailure extends CheckTokenState {
 @override
 List<Object> get props => [];
}