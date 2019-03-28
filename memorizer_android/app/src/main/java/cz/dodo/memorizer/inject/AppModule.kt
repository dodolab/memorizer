package cz.dodo.memorizer.inject

import android.app.Application
import dagger.Module
import dagger.Provides
import com.google.gson.GsonBuilder


@Module
class AppModule(private val application: Application) {

    @Provides
    fun provideContext() = application

    @Provides
    fun provideGson() = GsonBuilder()
            // todo register adapters if any
            .create()
}