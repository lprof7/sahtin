package com.example.data.user.model

/**
 * نموذج يمثل نتيجة محاولة تسجيل الدخول
 * @param success نجاح أو فشل عملية تسجيل الدخول
 * @param error رمز الخطأ في حالة الفشل (null في حالة النجاح)
 */
data class LoginResponse(
    val success: Boolean,
    val error: LoginError? = null
) {
    companion object {
        /**
         * إنشاء استجابة نجاح
         */
        fun success(): LoginResponse = LoginResponse(success = true)

        /**
         * إنشاء استجابة فشل مع رمز الخطأ
         */
        fun failure(error: LoginError): LoginResponse = LoginResponse(success = false, error = error)
    }
}