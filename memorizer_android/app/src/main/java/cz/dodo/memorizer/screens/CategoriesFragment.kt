package cz.dodo.memorizer.screens

import android.content.Context
import android.os.Bundle
import android.view.View
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import cz.dodo.memorizer.MemorizerApp
import cz.dodo.memorizer.R
import cz.dodo.memorizer.entities.Category
import cz.dodo.memorizer.extension.startFragmentActivity
import cz.dodo.memorizer.main.BaseFragment
import cz.dodo.memorizer.viewmodels.CategoriesViewModel
import kotlinx.android.synthetic.main.fragment_categories.*

class CategoriesFragment : BaseFragment() {

    override val shouldHaveActionBar: Boolean
        get() = true
    override val layoutId: Int
        get() = R.layout.fragment_categories

    companion object {
        fun newInstance(): CategoriesFragment {
            val fragment = CategoriesFragment()
            val args = Bundle(0)
            fragment.arguments = args
            return fragment
        }
    }

    override fun onAttach(context: Context) {
        MemorizerApp.getAppComponent(context).inject(this)
        super.onAttach(context)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val viewModel = ViewModelProviders.of(this, viewModelFactory)[CategoriesViewModel::class.java]
        list_categories.layoutManager = LinearLayoutManager(context)

        viewModel.speciesData.observe(this, Observer {
            list_categories.adapter = CategoriesAdapter(it.categories, onCategoryDetailClick)
        })
    }

    private var onCategoryDetailClick = object : CategoriesAdapter.OnCategoryClick {
        override fun performCategoryClick(category: Category) {
            startFragmentActivity<CategoryDetailFragment>(CategoryDetailFragment.newInstance(category))
        }
    }
}
