import 'package:dwarikesh/utils/colorUtils.dart';
import 'package:dwarikesh/widgets/progressPainter.dart';
import 'package:flutter/material.dart';

class GraphProgress extends StatelessWidget {
  String? percentage, title;
  Function()? onpress;
  GraphProgress({this.percentage, this.title, this.onpress});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey[100]!,
            width: 1,
          )),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: progressView(context, size, percentage!),
                ),
                Text(
                  title!,
                  style: TextStyle(
                    color: primaryColorDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: onpress,
                child: Container(
                  width: 35,
                  height: 35,
                  child: Icon(
                    Icons.error,
                    color: primaryColor,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  progressView(BuildContext context, Size size, String value) {
    return Container(
      padding: EdgeInsets.all(15),
      height: size.width / 2.0,
      width: size.width / 2,
      child: CustomPaint(
        child: Center(
          child: getProgressText(context),
        ),
        foregroundPainter: ProgressPainter(
            defaultCircleColor: Colors.grey[200]!,
            percentageCompletedCircleColor: primaryColor,
            completedPercentage: double.parse(value),
            circleWidth: 8.0),
      ),
    );
  }

  getProgressText(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: percentage,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.bold, fontSize: 24, color: primaryColor),
        children: <TextSpan>[
          TextSpan(
              text: ' %',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.bold)),
// can add more TextSpans here...
        ],
      ),
    );
  }
}
