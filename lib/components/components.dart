import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.black),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0))
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0))
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0))
  ),
  filled: true,
  fillColor: Colors.white,
);
Alert showAlert({
  required BuildContext context,
  required Function onPressed,
  required String title,
  required String description,
}){
  return Alert(
    context: context,
    type: AlertType.error,
    title: title,
    desc: description,
    buttons: [
      DialogButton(
        width: 120,
          onPressed: onPressed(),
          child: const Text('Ok', style: TextStyle(color: Colors.cyan, fontSize: 20),)
      )
    ]
  );
}

Alert signUpAlert({
  required BuildContext context,
  required String title,
  required String description,
  required String btnText,
  required Function onPressed
})
{
  return Alert(
    context: context,
    title: title,
    desc: description,
    buttons: [
      DialogButton(
          onPressed: onPressed(),
          child: Text(btnText, style: const TextStyle(color: Colors.white, fontSize: 20),)
      )
    ]
  );
}
Future<void> _dialogBuilder(
    BuildContext context,
    String title,
    String description,
    String btnText,
    Function onPressed)
{
  return showDialog<void>(context: context,
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: onPressed(),
              child: Text(btnText),
            ),
          ],
        );
      }
  );
}
