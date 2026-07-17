part of 'buy_tree_cubit.dart';

enum Status {initial, submitting, success, error, loading}


class BuyTreeState extends Equatable {

  final String email;
  final String projectId;
  final String name;
  final String phone;
  final String startLng;
  final String endLng;
  final Status? status;
  final OrderSuccessModel? orderSuccessModel;
  final String? error;


  const BuyTreeState({ required this.email,required this.projectId,required this.orderSuccessModel,required this.name,required this.status,required this.startLng,required this.phone, this.error, required this.endLng});

  factory BuyTreeState.initial(){
    return  BuyTreeState(
        email: "",
        name: "",
        status: Status.initial,
        startLng: "",
        phone: "JO",
        endLng: "",
        orderSuccessModel: OrderSuccessModel(),
        projectId: "",
        error: "Error"
    );
  }

  BuyTreeState copyWith({OrderSuccessModel? orderSuccessModel, String? email,String? projectId,String? endLng,String? startLng, String? name, Status? status,String? phone,String? error,}) {
    return BuyTreeState(
        email: email ?? this.email,
        status: status ?? this.status,
        name:  name ?? this.name,
        endLng: endLng ?? this.endLng,
        startLng: startLng ?? this.startLng,
        error: error ?? this.error,
        phone: phone ?? this.phone,
        projectId: projectId ?? this.projectId,
        orderSuccessModel: orderSuccessModel ?? this.orderSuccessModel

    );
  }

  @override
  List<Object?> get props => [email,projectId,status,name,endLng,orderSuccessModel,startLng,phone,error];
}