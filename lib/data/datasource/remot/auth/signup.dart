import 'package:delivery_app/core/class/crud.dart';

class SignupData {
  Crud crud;
  SignupData(this.crud);

  Future<dynamic> postdata(String firstName, String lastName, String? image,
      String location, String phone) async {
    var data = {
      "first_name": firstName,
      "last_name": lastName,
      "location": location,
      "mobile": phone,
    };

    // إذا كان هناك صورة مرفقة
    if (image != null) {
      data.addAll({"image": image});
    }

    var response = await crud.PostData(
        linkurl: "http://127.0.0.1:8000/auth/register", data: data, token: null);

    return response.fold((l) => l, (r) => r);
  }
}
