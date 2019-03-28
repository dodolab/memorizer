package cz.dodo.memorizer.main

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import javax.inject.Inject


class MainViewModel @Inject constructor(private val mainService: MainService) : ViewModel() {

    private val mutableLiveData: MutableLiveData<String> = MutableLiveData()

    init {
        mutableLiveData.value = mainService.giveMeSomeString()
    }

    val liveData: LiveData<String>
        get() = mutableLiveData

}