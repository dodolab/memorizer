package cz.dodo.memorizer.viewmodels

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import cz.dodo.memorizer.entities.SpeciesData
import cz.dodo.memorizer.main.MainService
import javax.inject.Inject


class MainViewModel @Inject constructor(private val mainService: MainService) : ViewModel() {

    private val mutableLiveData: MutableLiveData<String> = MutableLiveData()
    private val mutableData: MutableLiveData<SpeciesData> = MutableLiveData()

    init {
        mutableLiveData.value = mainService.giveMeSomeString()

        mainService.loadAssets()
                .subscribe { t1, t2 ->  mutableData.value = t1}
    }

    val liveData: LiveData<String>
        get() = mutableLiveData

    val speciesData: LiveData<SpeciesData>
        get() = mutableData

}