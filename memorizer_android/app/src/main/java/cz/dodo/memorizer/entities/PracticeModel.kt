package cz.dodo.memorizer.entities

import paperparcel.PaperParcel
import paperparcel.PaperParcelable
import java.io.Serializable

@PaperParcel
data class PracticeModel(val items: ArrayList<SpeciesItem>, val itemsNum: Int)  : PaperParcelable, Serializable {

    companion object {
        const val STATE_NEUTRAL = 1
        const val STATE_ERROR = 2
        const val STATE_CORRECT = 3

        @JvmField
        val CREATOR = PaperParcelPracticeModel.CREATOR
    }

    var failedItems : ArrayList<SpeciesItem> = arrayListOf()
    var failedAnswers: ArrayList<SpeciesItem> = arrayListOf()
    var currentIndex: Int = 0
    var offeredItems: ArrayList<SpeciesItem> = arrayListOf()
    var offeredItemStates = arrayListOf<Int>(STATE_NEUTRAL, STATE_NEUTRAL, STATE_NEUTRAL, STATE_NEUTRAL)
    var selectedItemIndex = 0
}
