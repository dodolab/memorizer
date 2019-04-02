package cz.dodo.memorizer.main


interface SharedPrefService {

    fun getLanguageCode(): String

    fun setLanguageCode(langCode: String)
}