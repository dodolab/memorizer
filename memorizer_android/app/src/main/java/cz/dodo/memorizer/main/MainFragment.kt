package cz.dodo.memorizer.main

import android.content.Context
import android.os.Bundle
import android.view.View
import cz.dodo.memorizer.DemoApplication
import cz.dodo.memorizer.R
import kotlinx.android.synthetic.main.fragment_main.*


class MainFragment : BaseFragment() {

    override val shouldHaveActionBar: Boolean
        get() = true

    override val layoutId: Int
        get() = R.layout.fragment_main

    override fun onAttach(context: Context) {
        DemoApplication.getAppComponent(context).inject(this)
        super.onAttach(context)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val pagerAdapter = MainPagerAdapter(childFragmentManager)
        layout_pager.adapter = pagerAdapter
        layout_tabs.setupWithViewPager(layout_pager)
    }
}
