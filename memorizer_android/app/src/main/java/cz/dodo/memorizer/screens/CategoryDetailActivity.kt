package cz.dodo.memorizer.screens

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import cz.dodo.memorizer.R

class CategoryDetailActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_detail)

        if (savedInstanceState == null) {
            val fragment = CategoryDetailFragment.newInstance()
            supportFragmentManager.beginTransaction().replace(R.id.layout_container, fragment).commit()
        }
    }
}
