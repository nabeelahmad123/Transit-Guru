class Validation{

  static bool validateEmail (email){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid;
  }

  static bool validateAllInputsRegistration(emailCorrect,passwordCorrect,confirmPasswordCorrect){
    return emailCorrect ==true&&passwordCorrect==true&&confirmPasswordCorrect==true;
  }

}