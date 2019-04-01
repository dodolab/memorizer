package cz.dodo.memorizer.screens

import android.content.Context
import android.os.Bundle
import android.view.View
import androidx.recyclerview.widget.LinearLayoutManager
import cz.dodo.memorizer.DemoApplication
import cz.dodo.memorizer.R
import cz.dodo.memorizer.entities.Category
import cz.dodo.memorizer.entities.SpeciesItem
import cz.dodo.memorizer.extension.onClick
import cz.dodo.memorizer.extension.startFragmentActivity
import cz.dodo.memorizer.main.BaseFragment
import kotlinx.android.synthetic.main.fragment_category_detail.*

class CategoryDetailFragment : BaseFragment() {

    override val layoutId: Int
        get() = R.layout.fragment_category_detail

    override val shouldHaveActionBar: Boolean
        get() = false

    companion object {
        const val KEY_CATEGORY = "CATEGORY"

        fun newInstance(category: Category): Bundle {
            val args = Bundle(0).also { it.putParcelable(KEY_CATEGORY, category) }
            return args
        }
    }

    override fun onAttach(context: Context) {
        DemoApplication.getAppComponent(context).inject(this)
        super.onAttach(context)
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        list_items.layoutManager = LinearLayoutManager(context)

        arguments?.let {
            val category = it.getParcelable<Category>(KEY_CATEGORY)
            toolbar_collapsing.title = category!!.name.cs
            list_items.adapter = CategoryItemsAdapter(category.items, onItemDetailClick)

            btn_practice.onClick {
                startFragmentActivity<PracticeConfirmFragment>(PracticeConfirmFragment.newInstance(category))
            }

            btn_gallery.onClick {
                startFragmentActivity<GalleryFragment>(GalleryFragment.newInstance(category))
            }
        }
    }

    private var onItemDetailClick = object : CategoryItemsAdapter.OnItemClick {
        override fun performItemClick(item: SpeciesItem) {

        }
    }
}
