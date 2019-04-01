package cz.dodo.memorizer.inject

import cz.dodo.memorizer.main.MainFragment
import cz.dodo.memorizer.screens.*
import dagger.Component
import javax.inject.Singleton


@Singleton
@Component(modules = [
    AppModule::class,
    ViewModelBuilder::class,
    MainModule::class
])
interface AppComponent {

    fun inject(mainFragment: MainFragment)

    fun inject(categoriesFragment: CategoriesFragment)

    fun inject(categoriesGridFragment: CategoriesGridFragment)

    fun inject(categoryDetailFragment: CategoryDetailFragment)

    fun inject(practiceConfirmFragment: PracticeConfirmFragment)

    fun inject(practiceFragment: PracticeFragment)
}