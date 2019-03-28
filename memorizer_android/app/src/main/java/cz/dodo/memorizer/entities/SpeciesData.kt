package cz.dodo.memorizer.entities

import paperparcel.PaperParcel
import paperparcel.PaperParcelable
import java.io.Serializable

@PaperParcel
data class SpeciesData(val categories: List<Category>)  : PaperParcelable, Serializable {
    companion object {
        @JvmField
        val CREATOR = PaperParcelSpeciesData.CREATOR
    }
}
