package cz.dodo.memorizer.screens

import android.content.Context
import android.os.Bundle
import android.view.View
import com.denzcoskun.imageslider.models.SlideModel
import cz.dodo.memorizer.MemorizerApp
import cz.dodo.memorizer.R
import cz.dodo.memorizer.entities.Category
import cz.dodo.memorizer.screens.base.BaseFragment
import kotlinx.android.synthetic.main.fragment_gallery.*

class GalleryFragment : BaseFragment() {

    override val layoutId: Int
        get() = R.layout.fragment_gallery

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
        MemorizerApp.getAppComponent(context).inject(this)
        super.onAttach(context)
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        arguments?.let {
            val category = it.getParcelable<Category>(KEY_CATEGORY)
            val imageList = ArrayList<SlideModel>()
            category.items.forEach {
                imageList.add(SlideModel(it.images.first(), it.name.cs))
            }
            slider_images.setImageList(imageList)
        }
    }

}
