package cz.dodo.memorizer.viewmodels

import android.os.Bundle
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import cz.dodo.memorizer.entities.Category
import cz.dodo.memorizer.models.PracticeModel
import cz.dodo.memorizer.models.PracticeResultModel
import cz.dodo.memorizer.entities.SpeciesItem
import cz.dodo.memorizer.services.PracticeService
import javax.inject.Inject
import kotlin.collections.ArrayList

class PracticeViewModel @Inject constructor(private val practiceService: PracticeService) : ViewModel() {

    companion object {
        const val KEY_MODEL = "MODEL"
    }

    val currentItem: MutableLiveData<SpeciesItem> = MutableLiveData()
    val nextItem: MutableLiveData<SpeciesItem> = MutableLiveData()

    val currentItemAnswers: MutableLiveData<List<SpeciesItem>> = MutableLiveData()

    val selectedAndCorrectAnswerIndex: MutableLiveData<Pair<Int, Int>> = MutableLiveData<Pair<Int, Int>>()

    lateinit var model : PracticeModel

    fun selectAnswer(index: Int) {
        val correctIndex = practiceService.submitItem(model, index)
        selectedAndCorrectAnswerIndex.value = Pair(index, correctIndex)
    }

    fun gotoNext(): Boolean {
        val output = practiceService.gotoNext(model)
        if(output){
            currentItem.value = model.items[model.currentIndex]
            if(practiceService.canGoNext(model)) {
                nextItem.value = model.items[model.currentIndex+1]
            }
            currentItemAnswers.value = model.offeredItems
        }
        return output
    }

    fun initViewModel(category: Category, itemsNum: Int) {
        model = PracticeModel(ArrayList(category.items), itemsNum)
        practiceService.initModel(model)
    }

    fun getResult() : PracticeResultModel {
        return PracticeResultModel(model.failedItems, model.failedAnswers, model.itemsNum)
    }

    fun saveState(output: Bundle) {
        output.putParcelable(KEY_MODEL, model)
    }

    fun restoreState(savedState: Bundle) {
        this.model = savedState.getParcelable(KEY_MODEL)
    }
}