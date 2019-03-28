package cz.dodo.memorizer.inject

import android.app.Application
import dagger.Module
import dagger.Provides


@Module
class AppModule(private val application: Application) {

    @Provides
    fun provideContext() = application

}