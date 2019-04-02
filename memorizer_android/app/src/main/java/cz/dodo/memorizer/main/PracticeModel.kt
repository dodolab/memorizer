package cz.dodo.memorizer.main

import cz.dodo.memorizer.entities.SpeciesItem
import paperparcel.PaperParcel
import paperparcel.PaperParcelable
import java.io.Serializable

@PaperParcel
data class PracticeModel(val items: ArrayList<SpeciesItem>, val itemsNum: Int)  : PaperParcelable, Serializable {

    companion object {
        @JvmField
        val CREATOR = PaperParcelPracticeModel.CREATOR
    }

    var failedItems : ArrayList<SpeciesItem> = arrayListOf()
    var failedAnswers: ArrayList<SpeciesItem> = arrayListOf()
    var currentIndex: Int = 0
    var offeredItems: ArrayList<SpeciesItem> = arrayListOf()
    var selectedItemIndex = 0
}
