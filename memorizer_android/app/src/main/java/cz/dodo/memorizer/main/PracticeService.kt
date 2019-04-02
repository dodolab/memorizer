package cz.dodo.memorizer.main

interface PracticeService {

    fun initModel(model: PracticeModel)

    fun canGoNext(model: PracticeModel) : Boolean

    fun gotoNext(model: PracticeModel): Boolean

    fun submitItem(model: PracticeModel, index: Int) : Int
}