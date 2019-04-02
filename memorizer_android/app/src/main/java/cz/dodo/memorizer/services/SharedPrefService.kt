package cz.dodo.memorizer.services


interface SharedPrefService {

    fun getLanguageCode(): String

    fun setLanguageCode(langCode: String)
}