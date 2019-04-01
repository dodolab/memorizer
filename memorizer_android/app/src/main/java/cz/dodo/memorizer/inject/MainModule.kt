package cz.dodo.memorizer.inject

import androidx.lifecycle.ViewModel
import cz.dodo.memorizer.main.CategoryService
import cz.dodo.memorizer.main.CategoryServiceImpl
import cz.dodo.memorizer.viewmodels.CategoriesViewModel
import cz.dodo.memorizer.viewmodels.PracticeConfirmViewModel
import dagger.Binds
import dagger.Module
import dagger.multibindings.IntoMap


@Module
internal abstract class MainModule {

    @Binds
    internal abstract fun bindCategoriesService(serviceImpl: CategoryServiceImpl): CategoryService

    @Binds
    @IntoMap
    @ViewModelKey(CategoriesViewModel::class)
    internal abstract fun bindCategoriesViewModel(viewModel: CategoriesViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(PracticeConfirmViewModel::class)
    internal abstract fun bindPracticeConfirmViewModel(viewModel: PracticeConfirmViewModel): ViewModel
}