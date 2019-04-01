package cz.dodo.memorizer.main

import cz.dodo.memorizer.entities.PracticeModel
import cz.dodo.memorizer.entities.SpeciesItem

interface PracticeService {

    fun initModel(model: PracticeModel)

    fun canGoNext(model: PracticeModel) : Boolean

    fun gotoNext(model: PracticeModel): Boolean

    fun submitItem(model: PracticeModel, index: Int) : Int
}