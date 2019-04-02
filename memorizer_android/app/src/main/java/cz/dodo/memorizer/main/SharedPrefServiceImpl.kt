package cz.dodo.memorizer.main

import android.app.Application
import android.content.Context
import android.content.SharedPreferences
import cz.dodo.memorizer.extension.putAndApply
import javax.inject.Inject

class SharedPrefServiceImpl  @Inject constructor(val app: Application) : SharedPrefService {

    val sharedPrefs: SharedPreferences

    companion object {
        const val KEY_LANG_CODE = "LANG_CODE"
    }

    init {
        sharedPrefs = app.getSharedPreferences("UserPreferences", Context.MODE_PRIVATE)
    }

    override fun getLanguageCode(): String {
        return sharedPrefs.getString(KEY_LANG_CODE, "en")!!
    }

    override fun setLanguageCode(langCode: String) {
        sharedPrefs.putAndApply(KEY_LANG_CODE, langCode)
    }

}
