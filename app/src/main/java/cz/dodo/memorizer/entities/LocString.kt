package cz.dodo.memorizer.entities

import paperparcel.PaperParcel
import paperparcel.PaperParcelable
import java.io.Serializable

@PaperParcel
data class LocString(val cs: String?, val en: String?, val la: String?)   : PaperParcelable, Serializable {

    companion object {
        @JvmField
        val CREATOR = PaperParcelLocString.CREATOR
    }

    fun getLocString(langCode: String) : String {
        val output = when(langCode) {
            "cs" -> cs
            "en" -> en
            "la" -> la
            else -> la
        }

        return output ?: la!! // default is latin
    }
}