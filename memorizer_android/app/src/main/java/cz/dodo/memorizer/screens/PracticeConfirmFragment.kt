package cz.dodo.memorizer.screens

import android.content.Context
import android.os.Bundle
import android.view.View
import androidx.lifecycle.ViewModelProviders
import cz.dodo.memorizer.DemoApplication
import cz.dodo.memorizer.R
import cz.dodo.memorizer.entities.Category
import cz.dodo.memorizer.main.BaseFragment
import cz.dodo.memorizer.viewmodels.PracticeConfirmViewModel

class PracticeConfirmFragment : BaseFragment() {

    var viewModel: PracticeConfirmViewModel? = null

    override val layoutId: Int
        get() = R.layout.fragment_practice_confirm

    override val shouldHaveActionBar: Boolean
        get() = true

    companion object {
        const val KEY_CATEGORY = "CATEGORY"

        fun newInstance(category: Category): Bundle {
            val fragment = CategoryDetailFragment()
            val args = Bundle(0).also { it.putParcelable(KEY_CATEGORY, category) }
            return args
        }
    }

    override fun onAttach(context: Context) {
        DemoApplication.getAppComponent(context).inject(this)
        super.onAttach(context)
    }

    override fun onResume() {
        super.onResume()
        viewModel?.let {
            setTitle(it.title)
        }
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel = ViewModelProviders.of(this, viewModelFactory)[PracticeConfirmViewModel::class.java]

        arguments?.let {
            val category = it.getParcelable<Category>(KEY_CATEGORY)
            category?.let { cat ->
                setTitle(cat.name.cs)
                viewModel?.title = cat.name.cs!!

            }
        }
    }
}
