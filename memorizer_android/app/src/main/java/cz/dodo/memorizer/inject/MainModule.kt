package cz.dodo.memorizer.inject

import androidx.lifecycle.ViewModel
import cz.dodo.memorizer.main.*
import cz.dodo.memorizer.viewmodels.CategoriesViewModel
import cz.dodo.memorizer.viewmodels.PracticeConfirmViewModel
import cz.dodo.memorizer.viewmodels.PracticeViewModel
import dagger.Binds
import dagger.Module
import dagger.multibindings.IntoMap


@Module
internal abstract class MainModule {

    @Binds
    internal abstract fun bindCategoriesService(serviceImpl: CategoryServiceImpl): CategoryService

    @Binds
    internal abstract fun bindSharedPrefService(serviceImpl: SharedPrefServiceImpl): SharedPrefService


    @Binds
    internal abstract fun bindPracticeService(serviceImpl: PracticeServiceImpl): PracticeService

    @Binds
    @IntoMap
    @ViewModelKey(CategoriesViewModel::class)
    internal abstract fun bindCategoriesViewModel(viewModel: CategoriesViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(PracticeConfirmViewModel::class)
    internal abstract fun bindPracticeConfirmViewModel(viewModel: PracticeConfirmViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(PracticeViewModel::class)
    internal abstract fun bindPracticeViewModel(viewModel: PracticeViewModel): ViewModel
}