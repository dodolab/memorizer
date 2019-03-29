package cz.dodo.memorizer.main

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import cz.dodo.memorizer.R
import cz.dodo.memorizer.screens.CategoriesFragment

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        if (savedInstanceState == null) {
            val fragment = CategoriesFragment.newInstance()
            supportFragmentManager.beginTransaction().replace(R.id.fragment_container, fragment).commit()
        }
    }
}
