package cz.dodo.memorizer.screens

import android.content.Context
import android.os.Bundle
import android.view.View
import cz.dodo.memorizer.MemorizerApp
import cz.dodo.memorizer.R
import cz.dodo.memorizer.entities.Category
import cz.dodo.memorizer.extension.onClick
import cz.dodo.memorizer.extension.startFragmentActivity
import cz.dodo.memorizer.screens.base.BaseFragment
import kotlinx.android.synthetic.main.fragment_practice_confirm.*

class PracticeConfirmFragment : BaseFragment() {

    override val layoutId: Int
        get() = R.layout.fragment_practice_confirm

    override val shouldHaveActionBar: Boolean
        get() = true

    override val title: String
        get() = getString(R.string.practice)

    companion object {
        const val KEY_CATEGORY = "CATEGORY"

        fun newInstance(category: Category): Bundle {
            val fragment = CategoryDetailFragment()
            val args = Bundle(0).also { it.putParcelable(KEY_CATEGORY, category) }
            return args
        }
    }

    override fun onAttach(context: Context) {
        MemorizerApp.getAppComponent(context).inject(this)
        super.onAttach(context)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        arguments?.let {
            val category = it.getParcelable<Category>(KEY_CATEGORY)
            category?.let { cat ->
                setTitle(cat.name.cs)
                seekbar_entities.minValue = 1
                seekbar_entities.value = cat.items.size
                seekbar_entities.maxValue = cat.items.size
            }

            btn_practice.onClick {
                activity?.finish()
                startFragmentActivity<PracticeFragment>(PracticeFragment.newInstance(category, seekbar_entities.value))
            }
        }
    }
}
