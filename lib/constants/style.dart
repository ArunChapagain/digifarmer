import 'package:digifarmer/extension/build_context.dart';
import 'package:digifarmer/theme/app_font.dart';
import 'package:flutter/material.dart';

TextStyle customTextStyle({
  FontWeight? fontWeight,
  double? fontSize,
  Color? color,
  TextOverflow? textOverflow,
  TextDecoration? txtDecoration = TextDecoration.none,
  double letterSpacing = 0,
  FontStyle? fontStyle,
  final double? textHeight,
}) {
  return TextStyle(
    fontWeight: fontWeight,
    fontSize: fontSize,
    decoration: txtDecoration,
    color: color,
    letterSpacing: letterSpacing,
    overflow: textOverflow,
    fontFamily: AppFonts.poppins.fontFamily,
    height: textHeight,
    fontStyle: fontStyle,
  );
}

class CustomGradientText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry padding;
  final int? maxLines;
  final Gradient gradient;
  const CustomGradientText({
    super.key,
    required this.text,
    required this.gradient,
    this.fontWeight,
    this.maxLines,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback:
          (bounds) => gradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
      child: CustomText(
        text: text,
        padding: padding,
        fontWeight: fontWeight,
        maxLines: maxLines,
      ),
    );
  }
}

class CustomRichText extends StatelessWidget {
  final String? firstText;
  final String? secondText;
  final Color? firstColor, secondColor;
  final TextStyle? style;
  final TextStyle? firstTextStyle;
  final TextStyle? secondTextStyle;
  final TextAlign textAlign;
  final List<TextSpan>? customTextSpans;
  final int? maxLines;

  const CustomRichText({
    super.key,
    this.firstText,
    this.secondText,
    this.style,
    this.firstTextStyle,
    this.secondTextStyle,
    this.textAlign = TextAlign.center,
    this.firstColor,
    this.secondColor,
    this.customTextSpans,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: textAlign,
      maxLines: maxLines,
      TextSpan(
        style: style ?? context.textTheme.bodyMedium,
        children:
            customTextSpans ??
            [
              TextSpan(
                text: firstText,
                style: firstTextStyle ?? customTextStyle(color: firstColor),
              ),
              TextSpan(
                text: secondText,
                style: secondTextStyle ?? customTextStyle(color: secondColor),
              ),
            ],
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final Color? color, decorationColor;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry padding;
  final int? maxLines;
  final double? fontSize;
  final double letterSpacing;
  final TextOverflow textOverflow;
  final List<Shadow>? shadows;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final TextStyle? style;
  final Function()? onTap;
  final double? textHeight;
  final bool isVisible;

  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.padding = EdgeInsets.zero,
    this.fontSize,
    this.letterSpacing = 0.1,
    this.textOverflow = TextOverflow.ellipsis,
    this.shadows,
    this.textDecoration = TextDecoration.none,
    this.textAlign = TextAlign.justify,
    this.onTap,
    this.style,
    this.textHeight,
    this.decorationColor,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          textAlign: textAlign,
          style:
              style ??
              context.textTheme.bodyMedium?.copyWith(
                color: color,
                fontSize: fontSize,
                fontWeight: fontWeight,
                height: textHeight,
                decoration: textDecoration,
                decorationColor: decorationColor,
              ),
          maxLines: maxLines,
          overflow: maxLines != null ? textOverflow : null,
        ),
      ),
    );
  }
}
