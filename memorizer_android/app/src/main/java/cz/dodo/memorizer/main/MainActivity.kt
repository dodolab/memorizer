package cz.dodo.memorizer.main

import android.os.Bundle
import androidx.fragment.app.FragmentActivity
import androidx.viewpager.widget.ViewPager
import cz.dodo.memorizer.R
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : FragmentActivity() {

    private lateinit var pagerAdapter: MainPagerAdapter
    private lateinit var viewPager: ViewPager

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // ViewPager and its adapters use support library
        // fragments, so use supportFragmentManager.
        pagerAdapter = MainPagerAdapter(supportFragmentManager)
        layout_pager.adapter = pagerAdapter

        layout_tabs.setupWithViewPager(layout_pager)
    }
}
