import 'package:flutter/material.dart';


class LoginFormProvider extends ChangeNotifier{

  // ** se usa una variable tipo global key que en este caso es de tipo FormState porque estamos trabajando en un form
  // ** pero podría varias el FormState según el widget usado

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = "";
  String password = "";

  bool isValidForm(){

    //vakudar su el estado del form es correcto

    print("Estado del VALIDADOR: ${formKey.currentState?.validate()}");


    return  formKey.currentState?.validate() ?? false;
  }

  //Simular un requerimiento backend cuando se ingresa el correo y contraseña

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value){
    _isLoading = value;
    //Cuando cambie el valor de Isloading se va a notificar al bloque de widget donde está el form
    notifyListeners();
  }


}