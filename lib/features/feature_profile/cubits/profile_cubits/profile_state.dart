part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {

}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
 @override
 List<Object> get props => [];
}

class ProfileDone extends ProfileState {
 final User? profile;

 ProfileDone({required this.profile});

  @override
 List<Object> get props => [profile!];
}


class ProfileFailure extends ProfileState {
 @override
 List<Object> get props => [];
}