package cz.dodo.memorizer.main

import cz.dodo.memorizer.entities.SpeciesData
import io.reactivex.Single

interface MainService {

    fun giveMeSomeString(): String

    fun loadAssets(): Single<SpeciesData>
}