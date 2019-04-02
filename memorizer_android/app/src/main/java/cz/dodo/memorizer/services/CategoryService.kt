package cz.dodo.memorizer.services

import cz.dodo.memorizer.entities.SpeciesData
import kotlinx.coroutines.Deferred

interface CategoryService {
    fun loadAssets(): Deferred<SpeciesData>
}