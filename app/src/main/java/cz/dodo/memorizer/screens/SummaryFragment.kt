package cz.dodo.memorizer.screens

import android.content.Context
import android.os.Bundle
import android.view.View
import androidx.recyclerview.widget.LinearLayoutManager
import cz.dodo.memorizer.MemorizerApp
import cz.dodo.memorizer.R
import cz.dodo.memorizer.models.PracticeResultModel
import cz.dodo.memorizer.entities.SpeciesItem
import cz.dodo.memorizer.screens.base.BaseFragment
import kotlinx.android.synthetic.main.fragment_summary.*

class SummaryFragment : BaseFragment() {

    override val layoutId: Int
        get() = R.layout.fragment_summary

    override val shouldHaveActionBar: Boolean
        get() = true

    override val title: String
        get() = getString(R.string.summary)

    companion object {
        const val KEY_RESULT = "RESULT"

        fun newInstance(result: PracticeResultModel): Bundle {
            val args = Bundle(0).also { it.putParcelable(KEY_RESULT, result) }
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
            val result = it.getParcelable<PracticeResultModel>(KEY_RESULT)
            txt_result.text = "${result.itemsNum - result.failedItems.size}/${result.itemsNum}"

            list_items.layoutManager = LinearLayoutManager(context)
            list_items.adapter = CategoryItemsAdapter(result.failedItems, onItemDetailClick, sharedPrefService.getLanguageCode())

        }
    }

    private var onItemDetailClick = object : CategoryItemsAdapter.OnItemClick {
        override fun performItemClick(item: SpeciesItem) {

        }
    }
}
