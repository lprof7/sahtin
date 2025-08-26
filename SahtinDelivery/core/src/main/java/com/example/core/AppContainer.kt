package com.example.core.di

import com.example.data.user.repository.UserRepository
import com.example.data.user.service.ApiUserService
import com.example.data.user.service.UserService
import com.google.firebase.auth.FirebaseAuth

/**
 * AppContainer is a dependency injection container that provides application-wide dependencies.
 * It replaces Hilt/Dagger for a simpler, more direct approach to dependency injection.
 */
class AppContainer {
    
    // Firebase Authentication instance
    private val firebaseAuth: FirebaseAuth by lazy {
        FirebaseAuth.getInstance()
    }
    
    // User service implementation
    val userService: UserService by lazy {
        ApiUserService(firebaseAuth)
    }
    
    // User repository implementation
    val userRepository: UserRepository by lazy {
        UserRepository(userService)
    }
    
    companion object {
        @Volatile
        private var INSTANCE: AppContainer? = null
        
        /**
         * Get the singleton instance of AppContainer
         * @return AppContainer instance
         */
        fun getInstance(): AppContainer {
            return INSTANCE ?: synchronized(this) {
                val instance = AppContainer()
                INSTANCE = instance
                instance
            }
        }
    }
}