package cz.dodo.memorizer.inject

import androidx.lifecycle.ViewModel
import cz.dodo.memorizer.main.MainService
import cz.dodo.memorizer.main.MainServiceImpl
import cz.dodo.memorizer.viewmodels.MainViewModel
import dagger.Binds
import dagger.Module
import dagger.multibindings.IntoMap


@Module
internal abstract class MainModule {

    @Binds
    @IntoMap
    @ViewModelKey(MainViewModel::class)
    internal abstract fun bindMainViewModel(viewModel: MainViewModel): ViewModel

    @Binds
    internal abstract fun bindMainService(serviceImpl: MainServiceImpl): MainService
}