package cz.dodo.memorizer.inject

import cz.dodo.memorizer.main.MainFragment
import cz.dodo.memorizer.screens.CategoriesFragment
import cz.dodo.memorizer.screens.CategoriesGridFragment
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
}