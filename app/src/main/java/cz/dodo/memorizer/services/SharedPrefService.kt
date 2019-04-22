package cz.dodo.memorizer.services

import androidx.lifecycle.LiveData


interface SharedPrefService {

    fun getLanguageCode(): String

    fun getLanguageCodeReactive() : LiveData<String>

    fun setLanguageCode(langCode: String)
}