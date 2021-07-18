import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/ui/input_decoration.dart';
import 'package:productos_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 170,
          ),
          CardContainer(
              child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Login",
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 30),

            // !! sólo lo que este dentro del loginFrom va a tener acceso al LoginFormProvider()
              ChangeNotifierProvider(
                create: (context)=>LoginFormProvider(),
                child:_LoginForm()),
              
            ],
          )),
          SizedBox(
            height: 30,
          ),
          Text(
            "Crear una nueva cuenta",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10,)
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

     final LoginFormProvider loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
        child: Form(
          key: loginForm.formKey,
          // ** Se valida el form cada vez que el usuario hace una interación
          autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
      children: [
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.authInputDecoration(
            hintText: "Example@example.com",
            labelText: "Correo electrónico",
            prefixIcon: Icons.alternate_email_rounded
          ),
          onChanged: (String value){
            loginForm.email = value;
          },
          validator: (String? value){
            
            //Evaluar correo
            String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';   
            RegExp regExp  = new RegExp(pattern);

            //si el value viene nulo, manéjelo como un String vacío
            return regExp.hasMatch(value ?? '')
            //como el método requiere "String? value", debo retornar un nullo o un String
            ? null
            :"El correo no tiene el formato adecuado";


          },
        ),
        SizedBox(height: 20,),
           TextFormField(
          autocorrect: false,
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.authInputDecoration(
            hintText: "****",
            labelText: "Contraseña",
            prefixIcon: Icons.lock_outline
          ),
          onChanged: (String value){
            loginForm.password = value;
          },
            validator: (String? value){
            
              return (value!= null && value.length >= 6)
              ? null
              : "La contraseña debe tener 6 dígitos por lo menos";
          },
        ),
        SizedBox(height: 20.0,),
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          disabledColor: Colors.grey,
          elevation: 0,
          color: Colors.deepPurple,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 60,vertical: 12),
            child: Text(
              loginForm.isLoading
              ? "Espere..."
              :"Ingresar",
             style: TextStyle(color: Colors.white),),
          ),
          //Si isloading es true va devolver un nulo lo que hará que el botón se bloqueé, si isLoading is false,
          //devolverá la función; pongo la función asincrona ya que estoy simulando un requerimiento 
          onPressed: loginForm.isLoading ? null: () async{

            //Quitar el teclado
            FocusScope.of(context).unfocus();

            //si la validación está correcta, ir a la siguiente ventana y establece el 
            //valor Isloading como true simulando que se empieza la petición http
            if(!loginForm.isValidForm()){return;}
            loginForm.isLoading = true;

            //simular el tiermpo del requerimiento requerimiento

            await Future.delayed(Duration(seconds: 2));

            //TODO: Se validaría el backend
            loginForm.isLoading = false;
            Navigator.pushReplacementNamed(context, "home");
          })

      ],
    )));
  }
}
