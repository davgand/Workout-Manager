import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workout_manager/src/constants/enums.dart';

class WarmupTypeHelper {
  static String toValue(
    WarmupType type,
    BuildContext context,
  ) {
    switch (type) {
      case WarmupType.other:
        return AppLocalizations.of(context).other;
      case WarmupType.neck:
        return AppLocalizations.of(context).neck;
      case WarmupType.shoulder:
        return AppLocalizations.of(context).shoulder;
      case WarmupType.arm:
        return AppLocalizations.of(context).arm;
      case WarmupType.wrist:
        return AppLocalizations.of(context).wrist;
      case WarmupType.fingers:
        return AppLocalizations.of(context).fingers;
      case WarmupType.torso:
        return AppLocalizations.of(context).torso;
      case WarmupType.leg:
        return AppLocalizations.of(context).leg;
      case WarmupType.knee:
        return AppLocalizations.of(context).knee;
      case WarmupType.foot:
        return AppLocalizations.of(context).foot;
    }
  }

  static WarmupType toEnum(String enumString, BuildContext context) {
    return enumString == AppLocalizations.of(context).neck
        ? WarmupType.neck
        : enumString == AppLocalizations.of(context).shoulder
            ? WarmupType.shoulder
            : enumString == AppLocalizations.of(context).arm
                ? WarmupType.arm
                : enumString == AppLocalizations.of(context).wrist
                    ? WarmupType.wrist
                    : enumString == AppLocalizations.of(context).fingers
                        ? WarmupType.fingers
                        : enumString == AppLocalizations.of(context).torso
                            ? WarmupType.torso
                            : enumString == AppLocalizations.of(context).leg
                                ? WarmupType.leg
                                : enumString ==
                                        AppLocalizations.of(context).knee
                                    ? WarmupType.knee
                                    : enumString ==
                                            AppLocalizations.of(context).foot
                                        ? WarmupType.foot
                                        : WarmupType.other;
  }
}
