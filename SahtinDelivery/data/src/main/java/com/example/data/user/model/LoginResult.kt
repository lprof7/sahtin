package com.example.data.user.model

/**
 * نموذج يمثل نتيجة عملية تسجيل الدخول بشكل موحد للاستخدام في Repository
 */
sealed class LoginResult {
    /**
     * نجاح عملية تسجيل الدخول
     */
    object Success : LoginResult()

    /**
     * فشل عملية تسجيل الدخول مع رمز الخطأ
     */
    data class Failure(val error: LoginError) : LoginResult()
}