package cz.dodo.memorizer

import android.app.Application
import android.content.Context
import cz.dodo.memorizer.inject.AppComponent
import cz.dodo.memorizer.inject.AppModule
import cz.dodo.memorizer.inject.DaggerAppComponent
import com.squareup.picasso.Picasso
import com.jakewharton.picasso.OkHttp3Downloader
import java.util.Collections.singletonList
import okhttp3.OkHttpClient
import okhttp3.Protocol
import java.util.*


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

        val client = OkHttpClient.Builder()
                .protocols(Collections.singletonList(Protocol.HTTP_1_1))
                .build()

        val picasso = Picasso.Builder(this)
               // .downloader(OkHttp3Downloader(client))
                .build()

        Picasso.setSingletonInstance(picasso)
        appComponent = DaggerAppComponent.builder().appModule(AppModule(this)).build()
    }
}