import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String? title;
  final Function()? onTap;

  const SettingsItem({
    Key? key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 17,
          horizontal: 21,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title!,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: primaryColorDark,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
