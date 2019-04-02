package cz.dodo.memorizer.main

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

    override fun submitItem(model: PracticeModel, index: Int) : Int {
        val correctItem = model.items[model.currentIndex]
        val selectedItem = model.offeredItems[index]
        val isCorrect = selectedItem === correctItem
        model.selectedItemIndex = index

        if (!isCorrect) {
            model.failedItems.add(correctItem)
            model.failedAnswers.add(selectedItem)
            // find correct item
            for (i in 0 until model.offeredItems.size) {
                if (model.offeredItems[i] === correctItem) {
                    return i
                }
            }
        }

        return index
    }
}