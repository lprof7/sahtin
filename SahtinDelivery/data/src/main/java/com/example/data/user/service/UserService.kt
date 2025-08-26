package com.example.data.user.service

import com.example.data.user.model.LoginResponse

/**
 * واجهة تحدد خدمات المستخدم
 */
interface UserService {
    /**
     * تسجيل الدخول باستخدام البريد الإلكتروني وكلمة المرور
     * @param email البريد الإلكتروني للمستخدم
     * @param password كلمة المرور
     * @return استجابة تسجيل الدخول (نجاح أو فشل مع رمز الخطأ)
     */
    suspend fun login(email: String, password: String): LoginResponse
}