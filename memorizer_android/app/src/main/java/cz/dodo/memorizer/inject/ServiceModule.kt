package cz.dodo.memorizer.inject

import cz.dodo.memorizer.services.*
import dagger.Binds
import dagger.Module

@Module
internal abstract class ServiceModule {

    @Binds
    internal abstract fun bindCategoriesService(serviceImpl: CategoryServiceImpl): CategoryService

    @Binds
    internal abstract fun bindSharedPrefService(serviceImpl: SharedPrefServiceImpl): SharedPrefService


    @Binds
    internal abstract fun bindPracticeService(serviceImpl: PracticeServiceImpl): PracticeService
}