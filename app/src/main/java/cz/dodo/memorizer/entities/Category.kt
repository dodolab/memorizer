package cz.dodo.memorizer.entities

import paperparcel.PaperParcel
import paperparcel.PaperParcelable
import java.io.Serializable

@PaperParcel
data class Category(val name: LocString, val items: List<SpeciesItem>) : PaperParcelable, Serializable {

    companion object {
        @JvmField
        val CREATOR = PaperParcelCategory.CREATOR
    }
}