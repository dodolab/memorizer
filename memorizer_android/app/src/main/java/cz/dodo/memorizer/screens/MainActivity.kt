package cz.dodo.memorizer.screens

import cz.dodo.memorizer.screens.base.BaseFragmentActivity


class MainActivity : BaseFragmentActivity() {

    override fun getFragmentName(): String = MainFragment::class.java.name
}
