package cz.dodo.memorizer.viewmodels

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import cz.dodo.memorizer.entities.SpeciesData
import cz.dodo.memorizer.services.CategoryService
import javax.inject.Inject


class CategoriesViewModel @Inject constructor(private val categoryService: CategoryService) : ViewModel() {

    private val mutableData: MutableLiveData<SpeciesData> = MutableLiveData()

    init {
        categoryService
                .loadAssets()
                .subscribe { t1, t2 ->  mutableData.value = t1}
    }

    val speciesData: LiveData<SpeciesData>
        get() = mutableData

}