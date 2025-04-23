import 'package:betclic_app/res/app_colors.dart';
import 'package:flutter/material.dart';

class OffThemeExtension extends ThemeExtension<OffThemeExtension> {
  OffThemeExtension({required this.title1, required this.title2});

  OffThemeExtension.defaultValues()
    : title1 = TextStyle(
        color: AppColors.blueDark,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      title2 = TextStyle(
        color: AppColors.gray2,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      );

  final TextStyle title1;
  final TextStyle title2;

  @override
  ThemeExtension<OffThemeExtension> copyWith({
    TextStyle? title1,
    TextStyle? title2,
  }) {
    return OffThemeExtension(
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
    );
  }

  @override
  ThemeExtension<OffThemeExtension> lerp(
    covariant ThemeExtension<OffThemeExtension>? other,
    double t,
  ) {
    if (other is! OffThemeExtension) {
      return this;
    }

    return OffThemeExtension(
      title1: TextStyle.lerp(title1, other.title1, t)!,
      title2: TextStyle.lerp(title2, other.title2, t)!,
    );
  }
}

extension OffThemeDartExtension on BuildContext {
  OffThemeExtension get theme => extension<OffThemeExtension>();

  T extension<T>() {
    return Theme.of(this).extension<T>()!;
  }
}
