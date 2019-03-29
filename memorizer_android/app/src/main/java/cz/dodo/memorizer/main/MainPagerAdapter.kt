package cz.dodo.memorizer.main

import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentStatePagerAdapter
import cz.dodo.memorizer.screens.CategoriesFragment

class MainPagerAdapter(fm: FragmentManager) : FragmentStatePagerAdapter(fm) {

    override fun getCount(): Int  = 2

    override fun getItem(i: Int): Fragment {
        return when(i){
            0 -> CategoriesFragment.newInstance()
            1 -> MainFragment.newInstance()
            else -> MainFragment.newInstance()
        }
    }

    override fun getPageTitle(position: Int): CharSequence {
        return "OBJECT " + (position + 1)
    }
}
