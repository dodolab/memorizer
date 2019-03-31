package cz.dodo.memorizer.screens

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import cz.dodo.memorizer.DemoApplication
import cz.dodo.memorizer.R
import cz.dodo.memorizer.entities.Category
import cz.dodo.memorizer.viewmodels.CategoriesViewModel
import kotlinx.android.synthetic.main.fragment_categories.*
import javax.inject.Inject

class CategoriesFragment : androidx.fragment.app.Fragment() {

    @Inject
    lateinit var viewModelFactory: ViewModelProvider.Factory

    companion object {

        fun newInstance(): CategoriesFragment {
            val fragment = CategoriesFragment()
            val args = Bundle(0)
            fragment.arguments = args
            return fragment
        }
    }

    override fun onAttach(context: Context) {
        DemoApplication.getAppComponent(context).inject(this)
        super.onAttach(context)
    }


    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_categories, container, false)
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
            val intent = Intent(context, CategoryDetailActivity::class.java)
            intent.putExtra("mojo", "dojo")
            startActivity(intent)
        }
    }
}
