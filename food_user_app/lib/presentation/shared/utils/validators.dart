String? validateEmail(String? value, l10n) {
  if (value == null || value.isEmpty) {
    return l10n.emailRequired;
  }
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return l10n.emailInvalid;
  }
  return null;
}
