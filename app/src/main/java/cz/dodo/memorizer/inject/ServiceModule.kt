package cz.dodo.memorizer.inject

import cz.dodo.memorizer.services.*
import dagger.Binds
import dagger.Module
import javax.inject.Singleton

@Module
internal abstract class ServiceModule {

    @Binds
    @Singleton
    internal abstract fun bindCategoriesService(serviceImpl: CategoryServiceImpl): CategoryService

    @Binds
    @Singleton
    internal abstract fun bindSharedPrefService(serviceImpl: SharedPrefServiceImpl): SharedPrefService


    @Binds
    @Singleton
    internal abstract fun bindPracticeService(serviceImpl: PracticeServiceImpl): PracticeService
}