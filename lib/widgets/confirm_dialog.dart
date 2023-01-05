import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/material.dart';

showConfirmDialog({
  BuildContext? context,
  String? message,
  String? action1,
  String? action2,
  Function()? onPressed,
}) {
  showDialog(
    barrierDismissible: true,
    context: context!,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        // child: WaitCircularProgress(title: 'Please wait'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 52,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                message! + '\n',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 18),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 62,
              margin: EdgeInsets.only(top: 51),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xffbac0cb).withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 62,
                        alignment: Alignment.center,
                        child: Text(
                          action1!.toUpperCase(),
                          style: TextStyle(
                            color: primaryColorDark,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    width: 1,
                    color: Color(0xffbac0cb).withOpacity(0.5),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onPressed,
                      child: Container(
                        height: 62,
                        alignment: Alignment.center,
                        child: Text(
                          action2!.toUpperCase(),
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
