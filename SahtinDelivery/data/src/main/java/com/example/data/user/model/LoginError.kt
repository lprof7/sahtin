package com.example.data.user.model

/**
 * تعداد يمثل أنواع أخطاء تسجيل الدخول المحتملة
 */
enum class LoginError {
    /** كلمة المرور غير صحيحة */
    WRONG_PASSWORD,
    
    /** المستخدم غير موجود */
    USER_NOT_FOUND,
    
    /** خطأ في الاتصال بالشبكة */
    NETWORK_ERROR,
    
    /** تجاوز الحد المسموح من المحاولات */
    TOO_MANY_REQUESTS,
    
    /** خطأ غير معروف */
    UNKNOWN
}