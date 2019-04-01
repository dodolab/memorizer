package cz.dodo.memorizer.screens

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import cz.dodo.memorizer.DemoApplication
import cz.dodo.memorizer.R
import cz.dodo.memorizer.databinding.FragmentPracticeConfirmBinding
import cz.dodo.memorizer.entities.Category
import cz.dodo.memorizer.extension.onClick
import cz.dodo.memorizer.extension.startFragmentActivity
import cz.dodo.memorizer.main.BaseFragment
import cz.dodo.memorizer.viewmodels.PracticeConfirmViewModel
import kotlinx.android.synthetic.main.fragment_practice_confirm.*

class PracticeConfirmFragment : BaseFragment() {

    var viewModel: PracticeConfirmViewModel? = null
    lateinit var binding: FragmentPracticeConfirmBinding

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
            setTitle("Practice")
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        super.onCreateView(inflater, container, savedInstanceState)

        binding = DataBindingUtil.inflate(inflater, layoutId, container, false)
        binding.data = viewModel
        // restore binding states
        savedInstanceState?.let { binding.executePendingBindings() }
        return binding.root
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewModel = ViewModelProviders.of(this, viewModelFactory)[PracticeConfirmViewModel::class.java]

        arguments?.let {
            val category = it.getParcelable<Category>(KEY_CATEGORY)
            category?.let { cat ->
                setTitle(cat.name.cs)
                viewModel?.title = cat.name.cs!!
                seekbar_entities.minValue = 1
                seekbar_entities.value = cat.items.size
                seekbar_entities.maxValue = cat.items.size
            }


            btn_practice.onClick {
                startFragmentActivity<PracticeFragment>(PracticeFragment.newInstance(category, seekbar_entities.value))
            }
        }
    }
}
