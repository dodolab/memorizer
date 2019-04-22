package cz.dodo.memorizer.inject

import androidx.lifecycle.ViewModel
import cz.dodo.memorizer.viewmodels.CategoriesViewModel
import cz.dodo.memorizer.viewmodels.PracticeViewModel
import dagger.Binds
import dagger.Module
import dagger.multibindings.IntoMap

@Module
internal abstract class ViewModelModule {

    @Binds
    @IntoMap
    @ViewModelKey(CategoriesViewModel::class)
    internal abstract fun bindCategoriesViewModel(viewModel: CategoriesViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(PracticeViewModel::class)
    internal abstract fun bindPracticeViewModel(viewModel: PracticeViewModel): ViewModel
}