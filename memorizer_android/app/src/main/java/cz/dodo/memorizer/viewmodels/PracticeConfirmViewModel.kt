package cz.dodo.memorizer.viewmodels

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import javax.inject.Inject

class PracticeConfirmViewModel @Inject constructor() : ViewModel() {
    val sliderValue: MutableLiveData<Int> = MutableLiveData()

    var title: String = ""
}