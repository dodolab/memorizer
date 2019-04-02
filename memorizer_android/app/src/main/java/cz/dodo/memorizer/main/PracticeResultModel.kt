package cz.dodo.memorizer.main

import cz.dodo.memorizer.entities.SpeciesItem
import paperparcel.PaperParcel
import paperparcel.PaperParcelable
import java.io.Serializable

@PaperParcel
data class PracticeResultModel(val failedItems: ArrayList<SpeciesItem>, val failedAnswers: ArrayList<SpeciesItem>, val itemsNum: Int)  : PaperParcelable, Serializable {

    companion object {
        @JvmField
        val CREATOR = PaperParcelPracticeResultModel.CREATOR
    }
}
