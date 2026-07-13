import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:letjordangreen/core/functions/get_header_for_requests.dart';
import 'package:letjordangreen/core/hive/user.dart';
import 'package:letjordangreen/core/states/base_states.dart';
import 'package:letjordangreen/core/utils/constants/constants.dart';
import 'package:letjordangreen/features/feature_inspection_queue/data/models/inspection_queue_model.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';

class InspectionQueueCubit extends Cubit<BaseState<InspectionQueueModel>> {
  InspectionQueueCubit() : super(InitialState());

  List<Doc> branches = [];

  UserInformationCubit userInformationCubit = UserInformationCubit();
  late UserHiveModel userHiveModel;

  Future<void> getRestaurantOrders() async {
    userHiveModel = userInformationCubit.state.userHiveModel;
    try {
      emit(LoadingState());

      final response = await http.get(
          Uri.parse("$baseUrl/trees?page=1&limit=100"),
          headers: getHeader(HeaderType.withToken)
      );

      log("get Restaurant Orders  ${response.statusCode}");

      if (response.statusCode == 200) {
        branches = inspectionQueueModelFromJson(response.body).docs!;
        emit(SuccessState(inspectionQueueModelFromJson(response.body)));
      } else {
        emit(ErrorState());
      }
    } catch (e) {
      emit(ErrorState());
    }
  }

  void updateOrderLocally(String orderId, Map<String, dynamic> updatedFields) {
    final currentState = state;

    if (currentState is SuccessState<InspectionQueueModel>) {
      // Get current docs
      List<Doc> updatedDocs = List.from(currentState.data.docs ?? []);

      // Find and update the specific order
      final index = updatedDocs.indexWhere((doc) => doc.id == orderId);

      if (index != -1) {
        final existingDoc = updatedDocs[index];

        // Create updated doc with new values
        final updatedDoc = existingDoc.copyWith(
          verificationStatus: updatedFields['verificationStatus'] ?? existingDoc.verificationStatus,
          rejectionReason: updatedFields['rejectionReason'] ?? existingDoc.rejectionReason,
          rejectionCount: updatedFields['rejectionCount'] ?? existingDoc.rejectionCount,
          payoutAmount: updatedFields['payoutAmount'] ?? existingDoc.payoutAmount,
          payoutStatus: updatedFields['payoutStatus'] ?? existingDoc.payoutStatus,
          // Add any other fields you want to update
        );

        // Replace the old doc with the updated one
        updatedDocs[index] = updatedDoc;

        // Update the branches list
        branches = updatedDocs;

        // Create new model with updated docs
        final updatedModel = InspectionQueueModel(
          docs: updatedDocs,
          totalDocs: currentState.data.totalDocs,
          totalPages: currentState.data.totalPages,
          currentPage: currentState.data.currentPage,
          limit: currentState.data.limit,
        );

        // Emit new state with updated data
        emit(SuccessState(updatedModel));
      }
    }
  }

  // Future<void> updateOrderStatus(String orderId, String newStatus, String oldStatus) async {
  //   userHiveModel = userInformationCubit.state.userHiveModel;
  //   try {
  //
  //     final Map<String, dynamic> updateData = {
  //       'rejectionReason' : oldStatus,
  //       'status': newStatus,
  //     };
  //
  //     final response = await http.put(
  //       Uri.parse("$baseUrl/trees/$orderId/verify"),
  //       headers: getHeader(HeaderType.withToken),
  //       body: updateData,
  //     );
  //
  //     log("Update Order Status ${response.body} ${response.statusCode}");
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = jsonDecode(response.body);
  //       final updatedOrder = OrdersModel.fromJson(responseData);
  //
  //       // Update local state
  //       final index = branches.indexWhere((order) => order.id == orderId);
  //       if (index != -1) {
  //         final updatedBranches = List<OrdersModel>.from(branches);
  //         updatedBranches[index] = updatedOrder;
  //         branches = updatedBranches;
  //         emit(SuccessState(updatedBranches));
  //       } else {
  //         emit(SuccessState([updatedOrder]));
  //       }
  //     } else {
  //       final errorBody = jsonDecode(response.body);
  //       log("Error: ${errorBody['message'] ?? 'Unknown error'}");
  //       emit(ErrorState());
  //       // You might want to emit a custom error state with the error message
  //     }
  //   } catch (e) {
  //     log("Error updating order: $e");
  //     emit(ErrorState());
  //     rethrow;
  //   }
  // }
  //
  // // Helper method to update order status locally without server call (if needed)
  // void updateOrderStatusLocally(String orderId, String newStatus) {
  //   final index = branches.indexWhere((order) => order.id == orderId);
  //   if (index != -1) {
  //     final updatedOrder = branches[index].copyWith(verificationStatus: newStatus);
  //     final updatedBranches = List<OrdersModel>.from(branches);
  //     updatedBranches[index] = updatedOrder;
  //     branches = updatedBranches;
  //     emit(SuccessState(updatedBranches));
  //   }
  // }
}


// approved
// rejected