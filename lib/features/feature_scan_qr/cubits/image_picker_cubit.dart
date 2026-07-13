import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:letjordangreen/core/hive/user.dart';
import 'package:letjordangreen/core/utils/constants/constants.dart';
import 'package:letjordangreen/features/feature_auth/feature_login/data/models/user.dart';
import 'package:letjordangreen/features/feature_user_information/cubits/user_information_cubit/user_information_cubit.dart';
import 'package:path/path.dart';

class ImagePickerCubit extends Cubit<File?> {
  ImagePickerCubit() : super(null);

  late Avatar avatar = Avatar();

   Future<File> pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(File(pickedFile.path));


      return File(pickedFile.path);
    } else {
      return File("");
    }
  }

  void processPickedFile(XFile? pickedFile) {
    if (pickedFile != null) {
      emit(File(pickedFile.path));
    } else {
      emit( File(""));
    }
  }

  Future<Avatar> uploadImage(File imageFile) async {
     UserInformationCubit userInformationCubit = UserInformationCubit();
     UserHiveModel userHiveModel;

    try {
      userHiveModel = userInformationCubit.state.userHiveModel;
      final url = Uri.parse('$baseUrl/trees/upload/only-images');

      var request = http.MultipartRequest(
        'POST',
        url,
      );
      request.files.add(await http.MultipartFile.fromPath('file', imageFile.path, filename: basename(imageFile.path)));

      request.headers['Authorization'] = 'Bearer ${userHiveModel.accessToken}';

      final response = await request.send();

      if (response.statusCode == 200) {
        http.Response response2 = await http.Response.fromStream(response);

        var jsonData = jsonDecode(response2.body);

        Avatar fileResponse = Avatar.fromJson(jsonData);

         log('Image uploaded successfully $jsonData');
        avatar = fileResponse;
        return Future.value(fileResponse);
      } else {
         log('Image upload failed ${response.statusCode}');
      }
      return Future.value(Avatar());
    } catch (e) {
       log('Error uploading image: $e');
      return Future.value(Avatar());

    }
  }

  void clearImage() {
    emit(null);
  }
}


