package cz.dodo.memorizer.services

import cz.dodo.memorizer.models.PracticeModel

interface PracticeService {

    fun initModel(model: PracticeModel)

    fun canGoNext(model: PracticeModel) : Boolean

    fun gotoNext(model: PracticeModel): Boolean

    fun submitItem(model: PracticeModel, index: Int) : Int
}