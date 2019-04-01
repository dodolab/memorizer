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
        fun newInstance(category: Category): Bundle {
            val args = Bundle(0)
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
        viewModel?.dispose()
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
            viewModel?.retrieve()
        }

        arguments?.let {
            //initializeMap(it.getSerializable(KEY_LINE) as Segment)
        }
    }
}