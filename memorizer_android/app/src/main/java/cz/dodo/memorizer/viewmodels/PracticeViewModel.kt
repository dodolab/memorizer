package cz.dodo.memorizer.viewmodels

import android.os.Bundle
import androidx.lifecycle.ViewModel
import cz.dodo.memorizer.entities.Category
import cz.dodo.memorizer.entities.PracticeModel
import cz.dodo.memorizer.main.PracticeService
import java.util.*
import javax.inject.Inject
import kotlin.collections.ArrayList

class PracticeViewModel @Inject constructor(private val practiceService: PracticeService) : ViewModel() {

    companion object {
        const val KEY_MODEL = "MODEL"
        const val KEY_CATEGORY = "CATEGORY"
    }

    var evaluationPending = false
    lateinit var model : PracticeModel
    lateinit var category: Category

    var rnd = Random()


    fun saveState(output: Bundle) {
        output.putParcelable(KEY_MODEL, model)
        output.putParcelable(KEY_CATEGORY, category)
    }

    fun restoreState(savedState: Bundle) {
        this.model = savedState.getParcelable(KEY_MODEL)
        this.category = savedState.getParcelable(KEY_CATEGORY)
    }

    fun initViewModel(category: Category, itemsNum: Int) {
        model = PracticeModel(ArrayList(category.items), itemsNum)
    }

}