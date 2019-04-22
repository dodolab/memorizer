package cz.dodo.memorizer.services

import android.app.Application
import com.google.gson.Gson
import cz.dodo.memorizer.entities.SpeciesData
import kotlinx.coroutines.Deferred
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import javax.inject.Inject

class CategoryServiceImpl @Inject constructor(private val app: Application, private val gson: Gson) : CategoryService {

    override fun loadAssets(): Deferred<SpeciesData> {
        return GlobalScope.async {
            val manager = app.assets
            val file = manager.open("data.json")
            val formArray = ByteArray(file.available())
            file.read(formArray)
            file.close()

            val str = String(formArray)
            gson.fromJson(str, SpeciesData::class.java)
        }
    }
}