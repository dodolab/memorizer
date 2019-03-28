package cz.dodo.memorizer

import android.app.Application
import android.content.Context
import cz.dodo.memorizer.inject.AppComponent
import cz.dodo.memorizer.inject.AppModule
import cz.dodo.memorizer.inject.DaggerAppComponent


class DemoApplication : Application() {

    companion object {
        fun getAppComponent(context: Context): AppComponent {
            val app = context.applicationContext as DemoApplication
            return app.appComponent
        }
    }


    private lateinit var appComponent: AppComponent

    override fun onCreate() {
        super.onCreate()
        appComponent = DaggerAppComponent.builder().appModule(AppModule(this)).build()
    }
}