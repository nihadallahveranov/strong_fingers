import 'package:flutter/material.dart';
import 'package:gauges/gauges.dart';

import 'package:strong_fingers/colors.dart';

class ExpandedRadialGauge extends StatelessWidget {
  const ExpandedRadialGauge({
    Key? key,
    required this.modeTextColor,
    required this.radialGaugeValue,
  }) : super(key: key);

  final Color modeTextColor;
  final double radialGaugeValue;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: RadialGauge(
        radius: 75.0,
        axes: [
          RadialGaugeAxis(
            minValue: 0,
            maxValue: 100,
            color: Colors.transparent,
            pointers: [
              RadialNeedlePointer(
                knobRadius: 0.075,
                thicknessStart: 10,
                thicknessEnd: 1,
                value: radialGaugeValue,
                color: primaryColor,
                knobColor: modeTextColor,
                length: 0.75,
                thickness: 3.75,
              ),
            ],
            segments: <RadialGaugeSegment>[
              const RadialGaugeSegment(
                /// worst chart
                minValue: 0,
                maxValue: 20,
                minAngle: -150,
                maxAngle: -90,
                color: Colors.red,
              ),
              const RadialGaugeSegment(
                minValue: 20,
                maxValue: 40,
                minAngle: -90,
                maxAngle: -30,
                color: Colors.orange,
              ),
              const RadialGaugeSegment(
                minValue: 40,
                maxValue: 60,
                minAngle: -30,
                maxAngle: 30,
                color: Colors.yellow,
              ),
              const RadialGaugeSegment(
                minValue: 60,
                maxValue: 80,
                minAngle: 30,
                maxAngle: 90,
                color: Colors.lightGreen,
              ),
              const RadialGaugeSegment(
                minValue: 40,
                maxValue: 60,
                minAngle: 90,
                maxAngle: 150,
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
