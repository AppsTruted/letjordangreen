import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:letjordangreen/core/hive/user.dart';
import 'package:letjordangreen/core/utils/constants/constants.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';

part 'scan_qr_state.dart';

class ScanQrCubit extends Cubit<ScanQrState> {

  ScanQrCubit() : super(ScanQrState.initial());

  setStartLat( String startLat){
    emit(state.copyWith( startLat: startLat , status: Status.initial));
  }

  setStartLng( String startLng) {
    emit(state.copyWith( startLng: startLng ));
  }

  setEndLat( String endLat) {
    emit(state.copyWith( endLat: endLat ));
  }

  setProjectId( String projectId) {
    emit(state.copyWith( projectId: projectId ));
  }

  setEndLng( String endLng) {
    emit(state.copyWith( endLng: endLng ));
  }
  setUniqueCode( String uniqueCode) {
    emit(state.copyWith( uniqueCode: uniqueCode ));
  }
  UserInformationCubit userInformationCubit = UserInformationCubit();
  late UserHiveModel userHiveModel ;

  Future<Map<String, dynamic>> scanQrFunction(BuildContext context, {
    required String startLat,
    required String startLng,
    required String endLat,
    required String endLng,
    XFile? capturedImage
  }) async {
    emit(state.copyWith(status: Status.loading));

    if (state.status == Status.submitting) return{};
    emit(state.copyWith(status: Status.submitting));

    userHiveModel = userInformationCubit.state.userHiveModel;
    final uri = Uri.parse('$baseUrl/trees/scan/only-images');
    final request = http.MultipartRequest('POST', uri);

    // Add headers
    request.headers.addAll({
      'Authorization': 'Bearer ${userHiveModel.accessToken}',
      'Accept': 'application/json',
    });

    // Add text fields
    request.fields['uniqueCode'] = state.uniqueCode;
    request.fields['projectId'] = state.projectId;

    // Coordinates as JSON strings
    request.fields['startCoords'] = json.encode({
      'lat': startLat.toString(),
      'lng': startLng.toString(),
    });
    request.fields['endCoords'] = json.encode({
      'lat': endLat.toString(),
      'lng': endLng.toString(),
    });

    // Add image file
    final File imageFile = File(capturedImage!.path);
    final stream = http.ByteStream(imageFile.openRead());
    final length = await imageFile.length();

    final multipartFile = http.MultipartFile(
      'images',
      stream,
      length,
      filename: 'tree_${DateTime.now().millisecondsSinceEpoch}.jpg',
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(multipartFile);

    try {
      final response = await request.send().timeout(
        const Duration(seconds: 30),
      );
      final responseBody = await response.stream.bytesToString();
      log("responseBody ${response.statusCode} $responseBody");

      final Map<String, dynamic> responseData = json.decode(responseBody);

      if (response.statusCode == 200) {
        emit(state.copyWith(status: Status.success));
        // Reset state after success
        emit(ScanQrState.initial());
        return responseData; // Return the response for the widget to handle
      }
      else if (response.statusCode == 400) {
        // Handle validation errors
        emit(state.copyWith(
            status: Status.error,
            error: responseData['message'] ?? 'Validation error'
        ));
        return responseData;
      }
      else if (response.statusCode == 409) {
        // Handle QR code already used
        emit(state.copyWith(
            status: Status.error,
            error: 'This QR code has already been used'
        ));
        return responseData;
      }
      else {
        emit(state.copyWith(
            status: Status.error,
            error: responseData['message'] ?? 'Error uploading tree photo'
        ));
        return responseData;
      }
    } catch (e) {
      emit(state.copyWith(
          status: Status.error,
          error: 'Network error: ${e.toString()}'
      ));
      rethrow;
    } finally {
      // Ensure loading state is reset even if there's an error
      if (state.status != Status.success) {
        // Don't reset immediately if we want to show error state
      }
    }
  }
  initCubit(){
    emit(ScanQrState.initial());
  }


  void showCanNotRateMoreThanFiveTimesDialog(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width ,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(1.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 30,
              children: [
                Center(
                  child: SvgPicture.asset("assets/svg/Artboard 1.svg",
                    height: 85,
                    color: Colors.white,
                    fit: BoxFit.cover,),
                ),
                Spacer(),
                Text(
                  "Sorry!!!".toUpperCase(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "You can only rate a few times per day.".toUpperCase(),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),

              ],
            ),
          ),
        );
      },
    );
  }
}