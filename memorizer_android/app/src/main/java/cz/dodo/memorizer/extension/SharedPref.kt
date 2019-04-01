package cz.dodo.memorizer.extension

import android.content.SharedPreferences

/**
 * Extension function to [SharedPreferences] that will put string and immediately apply changes
 */
fun SharedPreferences.putAndApply(key: String, value: String?) = edit().putString(key, value).apply()


/**
 * Extension function to [SharedPreferences] that will put int and immediately apply changes
 */
fun SharedPreferences.putAndApply(key: String, value: Int) = edit().putInt(key, value).apply()


/**
 * Extension function to [SharedPreferences] that will put boolean and immediately apply changes
 */
fun SharedPreferences.putAndApply(key: String, value: Boolean) = edit().putBoolean(key, value).apply()

/**
 * Extension function to [SharedPreferences] that will put float and immediately apply changes
 */
fun SharedPreferences.putAndApply(key: String, value: Float) = edit().putFloat(key, value).apply()

/**
 * Extension function to [SharedPreferences] that will put long and immediately apply changes
 */
fun SharedPreferences.putAndApply(key: String, value: Long) = edit().putLong(key, value).apply()

/**
 * Extension function to [SharedPreferences] that will put set of strings and immediately apply changes
 */
fun SharedPreferences.putAndApply(key: String, value: Set<String>) = edit().putStringSet(key, value).apply()
