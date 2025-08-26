package com.example.data.user.model

data class User(
    val id: String,
    val email: String,
    val firstName: String,
    val lastName: String,
    val phone: String,
    val currentPositionY: Double,
    val currentPositionX: Double
)