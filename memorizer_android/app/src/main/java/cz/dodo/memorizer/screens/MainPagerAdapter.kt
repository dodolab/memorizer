package cz.dodo.memorizer.screens

import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentStatePagerAdapter

class MainPagerAdapter(fm: FragmentManager) : FragmentStatePagerAdapter(fm) {

    override fun getCount(): Int  = 2

    override fun getItem(i: Int): Fragment {
        return when(i){
            0 -> CategoriesFragment()
            1 -> CategoriesGridFragment()
            else -> CategoriesFragment()
        }
    }
}
