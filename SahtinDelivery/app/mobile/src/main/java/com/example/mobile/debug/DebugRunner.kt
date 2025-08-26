/*
 * Copyright (C) 2023 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.example.mobile.debug

import com.example.core.di.AppContainer
import kotlinx.coroutines.runBlocking
import com.example.data.user.service.ApiUserService

fun main() = runBlocking {
    val appContainer = AppContainer.getInstance()
    appContainer.userService.login("username", "password")
    // مثال: طباعة بيانات المستخدم
    //println("User Repository: $userRepository.")
    // يمكنك إضافة المزيد من الاستدعاءات هنا لاختبار الخدمات الأخرى
    }