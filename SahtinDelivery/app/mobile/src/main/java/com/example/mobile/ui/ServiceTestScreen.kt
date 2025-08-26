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

package com.example.mobile.ui

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.example.core.di.AppContainer
import com.example.data.user.model.LoginError
import com.example.data.user.model.LoginResult
import kotlinx.coroutines.launch

/**
 * شاشة لاختبار Service و Repository
 * تعرض نتائج استدعاء الخدمات والمستودعات
 */
@OptIn(ExperimentalMaterial3Api::class)

@Composable
fun ServiceTestScreen() {
    val appContainer = AppContainer.getInstance()
    val userService = appContainer.userService
    val userRepository = appContainer.userRepository
    
    var email by remember { mutableStateOf("") }
    var password by remember { mutableStateOf("") }
    var serviceResult by remember { mutableStateOf("") }
    var repositoryResult by remember { mutableStateOf("") }
    
    val coroutineScope = rememberCoroutineScope()
    val scrollState = rememberScrollState()
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
            .verticalScroll(scrollState),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        Text(
            text = "اختبار Service و Repository",
            style = MaterialTheme.typography.headlineMedium,
            textAlign = TextAlign.Center
        )
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // حقول الإدخال
        OutlinedTextField(
            value = email,
            onValueChange = { email = it },
            label = { Text("البريد الإلكتروني") },
            modifier = Modifier.fillMaxWidth()
        )
        
        OutlinedTextField(
            value = password,
            onValueChange = { password = it },
            label = { Text("كلمة المرور") },
            modifier = Modifier.fillMaxWidth()
        )
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // أزرار الاختبار
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            Button(
                onClick = {
                    coroutineScope.launch {
                        try {
                            val response = userService.login(email, password)
                            serviceResult = "نتيجة Service:\n" +
                                    "نجاح: ${response.success}\n" +
                                    "خطأ: ${response.error?.name ?: "لا يوجد"}"
                        } catch (e: Exception) {
                            serviceResult = "خطأ في Service: ${e.message}"
                        }
                    }
                },
                modifier = Modifier.weight(1f)
            ) {
                Text("اختبار Service")
            }
            
            Button(
                onClick = {
                    coroutineScope.launch {
                        try {
                            val result = userRepository.login(email, password)
                            repositoryResult = when (result) {
                                is LoginResult.Success -> "نتيجة Repository:\nنجاح"
                                is LoginResult.Failure -> "نتيجة Repository:\n" +
                                        "فشل: ${result.error.name}"
                            }
                        } catch (e: Exception) {
                            repositoryResult = "خطأ في Repository: ${e.message}"
                        }
                    }
                },
                modifier = Modifier.weight(1f)
            ) {
                Text("اختبار Repository")
            }
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // عرض النتائج
        Card(
            modifier = Modifier.fillMaxWidth()
        ) {
            Column(
                modifier = Modifier.padding(16.dp),
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                Text(
                    text = "نتائج الاختبار",
                    style = MaterialTheme.typography.titleMedium
                )
                
                Divider()
                
                if (serviceResult.isNotEmpty()) {
                    Text(serviceResult)
                }
                
                if (repositoryResult.isNotEmpty()) {
                    if (serviceResult.isNotEmpty()) {
                        Divider()
                    }
                    Text(repositoryResult)
                }
                
                if (serviceResult.isEmpty() && repositoryResult.isEmpty()) {
                    Text("لم يتم إجراء أي اختبار بعد")
                }
            }
        }
    }
}