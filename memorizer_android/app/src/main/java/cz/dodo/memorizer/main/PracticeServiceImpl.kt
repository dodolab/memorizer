package cz.dodo.memorizer.main

import cz.dodo.memorizer.entities.PracticeModel
import cz.dodo.memorizer.entities.PracticeModel.Companion.STATE_CORRECT
import cz.dodo.memorizer.entities.PracticeModel.Companion.STATE_ERROR
import cz.dodo.memorizer.entities.PracticeModel.Companion.STATE_NEUTRAL
import cz.dodo.memorizer.entities.SpeciesItem
import java.util.*
import javax.inject.Inject

class PracticeServiceImpl  @Inject constructor() : PracticeService {

    var rnd = Random()

    override fun initModel(model: PracticeModel) {
        model.items.shuffle()
        model.currentIndex = -1
    }

    override fun canGoNext(model: PracticeModel): Boolean {
        return (model.currentIndex < model.itemsNum - 1)
    }

    override fun gotoNext(model: PracticeModel): Boolean {
        if (!canGoNext(model)) return false

        val offeredItemStates = arrayListOf(
            STATE_NEUTRAL,
            STATE_NEUTRAL,
            STATE_NEUTRAL,
            STATE_NEUTRAL
        )

        model.currentIndex++

        val offerIndices = arrayListOf<Int>()
        offerIndices.add(model.currentIndex)

        while (true) {
            val next = rnd.nextInt(model.items.size - 1)
            if (!offerIndices.contains(next)) {
                offerIndices.add(next)
            }
            if (offerIndices.size == 4) break
        }

        offerIndices.shuffle()

        model.offeredItems.clear()
        offerIndices.forEach { idx -> model.offeredItems.add(model.items[idx]) }
        return true
    }

    override fun submitItem(model: PracticeModel, item: SpeciesItem, index: Int) {
        val correctItem = model.items[model.currentIndex]
        val isCorrect = item === correctItem
        model.offeredItemStates[index] = if (isCorrect) STATE_CORRECT else STATE_ERROR
        model.selectedItemIndex = index

        if (!isCorrect) {
            model.failedItems.add(correctItem)
            model.failedAnswers.add(item)
            // find correct item
            for (i in 0 until model.offeredItems.size) {
                if (model.offeredItems[i] === correctItem) {
                    model.offeredItemStates[i] = STATE_CORRECT
                    break
                }
            }
        }
    }
}