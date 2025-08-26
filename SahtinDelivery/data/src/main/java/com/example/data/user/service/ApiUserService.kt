package com.example.data.user.service

import com.example.data.user.model.LoginError
import com.example.data.user.model.LoginResponse
import com.google.firebase.FirebaseNetworkException
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseAuthInvalidCredentialsException
import com.google.firebase.auth.FirebaseAuthInvalidUserException
import kotlinx.coroutines.tasks.await

/**
 * Implementation of UserService using Firebase Authentication
 */
class ApiUserService(
    private val firebaseAuth: FirebaseAuth
) : UserService {

    /**
     * تسجيل الدخول باستخدام البريد الإلكتروني وكلمة المرور عبر Firebase
     */
    override suspend fun login(email: String, password: String): LoginResponse {
        return try {
            // محاولة تسجيل الدخول باستخدام Firebase
            firebaseAuth.signInWithEmailAndPassword(email, password).await()
            // إذا نجحت العملية، نعيد استجابة نجاح
            LoginResponse.success()
        } catch (e: Exception) {
            // تحويل استثناءات Firebase إلى رموز أخطاء محددة
            val error = when (e) {
                is FirebaseAuthInvalidCredentialsException -> LoginError.WRONG_PASSWORD
                is FirebaseAuthInvalidUserException -> LoginError.USER_NOT_FOUND
                is FirebaseNetworkException -> LoginError.NETWORK_ERROR
                else -> {
                    // التحقق من رسالة الخطأ لمعرفة إذا كان تجاوز للحد المسموح
                    if (e.message?.contains("too many requests", ignoreCase = true) == true) {
                        LoginError.TOO_MANY_REQUESTS
                    } else {
                        LoginError.UNKNOWN
                    }
                }
            }
            // إعادة استجابة فشل مع رمز الخطأ
            LoginResponse.failure(error)
        }
    }
}