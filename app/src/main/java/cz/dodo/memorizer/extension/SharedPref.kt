package cz.dodo.memorizer.extension

import android.content.SharedPreferences


fun SharedPreferences.putAndApply(key: String, value: String?) = edit().putString(key, value).apply()
fun SharedPreferences.putAndApply(key: String, value: Int) = edit().putInt(key, value).apply()
fun SharedPreferences.putAndApply(key: String, value: Boolean) = edit().putBoolean(key, value).apply()
fun SharedPreferences.putAndApply(key: String, value: Float) = edit().putFloat(key, value).apply()
fun SharedPreferences.putAndApply(key: String, value: Long) = edit().putLong(key, value).apply()
fun SharedPreferences.putAndApply(key: String, value: Set<String>) = edit().putStringSet(key, value).apply()
