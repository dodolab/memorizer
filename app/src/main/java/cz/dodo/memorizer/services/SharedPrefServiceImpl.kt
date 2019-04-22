package cz.dodo.memorizer.services

import android.app.Application
import android.content.Context
import android.content.SharedPreferences
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import cz.dodo.memorizer.extension.putAndApply
import javax.inject.Inject

class SharedPrefServiceImpl  @Inject constructor(val app: Application) : SharedPrefService {

    val sharedPrefs: SharedPreferences
    val langCodeLive = MutableLiveData<String>()

    companion object {
        const val KEY_LANG_CODE = "LANG_CODE"
    }

    init {
        sharedPrefs = app.getSharedPreferences("UserPreferences", Context.MODE_PRIVATE)
        langCodeLive.value = getLanguageCode()
    }

    override fun getLanguageCode(): String {
        return sharedPrefs.getString(KEY_LANG_CODE, "en")!!
    }

    override fun getLanguageCodeReactive() : LiveData<String> {
        return langCodeLive
    }

    override fun setLanguageCode(langCode: String) {
        sharedPrefs.putAndApply(KEY_LANG_CODE, langCode)
        langCodeLive.postValue(langCode)
    }

}
