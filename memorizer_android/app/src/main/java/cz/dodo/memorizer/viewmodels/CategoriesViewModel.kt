package cz.dodo.memorizer.viewmodels

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import cz.dodo.memorizer.entities.SpeciesData
import cz.dodo.memorizer.services.CategoryService
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import javax.inject.Inject


class CategoriesViewModel @Inject constructor(private val categoryService: CategoryService) : ViewModel() {

    private val mutableData: MutableLiveData<SpeciesData> = MutableLiveData()

    init {
        GlobalScope.launch {
            val data = categoryService.loadAssets().await()
            mutableData.postValue(data)
        }
    }

    val speciesData: LiveData<SpeciesData>
        get() = mutableData

}