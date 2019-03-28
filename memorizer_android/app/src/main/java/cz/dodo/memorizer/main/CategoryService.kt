package cz.dodo.memorizer.main

import cz.dodo.memorizer.entities.SpeciesData
import io.reactivex.Single

interface CategoryService {
    fun loadAssets(): Single<SpeciesData>
}