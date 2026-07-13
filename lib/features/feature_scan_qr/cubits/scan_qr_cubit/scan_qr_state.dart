part of 'scan_qr_cubit.dart';

enum Status {initial, submitting, success, error, loading}


class ScanQrState extends Equatable {

  final String uniqueCode;
  final String projectId;
  final String startLat;
  final String endLat;
  final String startLng;
  final String endLng;
  final Status? status;
  final String? error;


  const ScanQrState({ required this.uniqueCode,required this.projectId,required this.startLat,required this.status,required this.startLng,required this.endLat, this.error, required this.endLng});

  factory ScanQrState.initial(){
    return const ScanQrState(
        uniqueCode: "",
        startLat: "",
        status: Status.initial,
        startLng: "",
        endLat: "JO",
        endLng: "",
        projectId: "",
        error: "Error"
    );
  }

  ScanQrState copyWith({String? email, String? uniqueCode,String? projectId,String? endLng,String? startLng, String? startLat, Status? status,String? endLat,String? error,}) {
    return ScanQrState(
        uniqueCode: uniqueCode ?? this.uniqueCode,
        status: status ?? this.status,
        startLat:  startLat ?? this.startLat,
        endLng: endLng ?? this.endLng,
        startLng: startLng ?? this.startLng,
        error: error ?? this.error,
        endLat: endLat ?? this.endLat,
        projectId: projectId ?? this.projectId

    );
  }

  @override
  List<Object?> get props => [uniqueCode,projectId,status,startLat,endLng,startLng,endLat,error];
}