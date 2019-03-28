package cz.dodo.memorizer.entities

import paperparcel.PaperParcel
import paperparcel.PaperParcelable
import java.io.Serializable

@PaperParcel
data class SpeciesItem(val name: LocString, val images: List<String>)  : PaperParcelable, Serializable {
    companion object {
        @JvmField
        val CREATOR = PaperParcelSpeciesItem.CREATOR
    }
}