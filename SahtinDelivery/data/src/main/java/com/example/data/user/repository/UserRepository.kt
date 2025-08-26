package com.example.data.user.repository

import com.example.data.user.model.LoginResult
import com.example.data.user.service.UserService

/**
 * User repository for handling user services
 */
class UserRepository(
    private val userService: UserService
) {
    /**
     * تسجيل الدخول باستخدام البريد الإلكتروني وكلمة المرور
     * @param email البريد الإلكتروني للمستخدم
     * @param password كلمة المرور
     * @return نتيجة تسجيل الدخول (نجاح أو فشل مع رمز الخطأ)
     */
    suspend fun login(email: String, password: String): LoginResult {
        val response = userService.login(email, password)
        
        return if (response.success) {
            LoginResult.Success
        } else {
            // نفترض أن الخطأ لن يكون null في حالة الفشل
            LoginResult.Failure(response.error!!)
        }
    }
}