package cz.dodo.memorizer.screens

import android.content.Context
import android.os.Bundle
import android.view.View
import cz.dodo.memorizer.DemoApplication
import cz.dodo.memorizer.R
import cz.dodo.memorizer.entities.Category
import cz.dodo.memorizer.main.BaseFragment
import cz.dodo.memorizer.viewmodels.PracticeViewModel

class PracticeFragment : BaseFragment() {

    var viewModel: PracticeViewModel? = null

    override val shouldHaveActionBar: Boolean
        get() = false

    override val layoutId: Int
        get() = R.layout.fragment_practice

    companion object {
        const val KEY_CATEGORY = "CATEGORY"
        const val KEY_ITEMS = "ITEMS"

        fun newInstance(category: Category, items: Int): Bundle {
            val args = Bundle(0)
            args.putParcelable(KEY_CATEGORY, category)
            args.putInt(KEY_ITEMS, items)
            return args
        }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        viewModel?.saveState(outState)
    }

    override fun onViewStateRestored(savedInstanceState: Bundle?) {
        super.onViewStateRestored(savedInstanceState)
        savedInstanceState?.let { viewModel?.restoreState(savedInstanceState) }
    }

    override fun onBackPressed() = if (progressShown()) {
        // hide progress and interrupt the current request
        hideProgress()
        true
    } else {
        super.onBackPressed()
    }


    override fun onAttach(context: Context) {
        DemoApplication.getAppComponent(context).inject(this)
        super.onAttach(context)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        if (savedInstanceState == null) {
            arguments?.let {it ->
                val category = it.getParcelable<Category>(KEY_CATEGORY)
                val itemsNum = it.getInt(KEY_ITEMS)
                viewModel?.initViewModel(category, itemsNum)
            }
        }
    }
}