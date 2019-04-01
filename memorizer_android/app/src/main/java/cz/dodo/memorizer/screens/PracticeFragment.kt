package cz.dodo.memorizer.screens

import android.content.Context
import android.os.Bundle
import android.view.View
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import com.squareup.picasso.Picasso
import cz.dodo.memorizer.DemoApplication
import cz.dodo.memorizer.R
import cz.dodo.memorizer.entities.Category
import cz.dodo.memorizer.extension.onClick
import cz.dodo.memorizer.main.BaseFragment
import cz.dodo.memorizer.viewmodels.PracticeViewModel
import kotlinx.android.synthetic.main.fragment_practice.*
import android.graphics.drawable.TransitionDrawable
import android.util.Log
import android.view.animation.AccelerateInterpolator
import android.view.animation.AlphaAnimation
import android.view.animation.Animation
import androidx.core.content.ContextCompat
import com.squareup.picasso.Callback
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import java.lang.Exception
import java.util.concurrent.atomic.AtomicBoolean


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

        viewModel = ViewModelProviders.of(this, viewModelFactory)[PracticeViewModel::class.java]

        if (savedInstanceState == null) {
            arguments?.let {it ->
                val category = it.getParcelable<Category>(KEY_CATEGORY)
                val itemsNum = it.getInt(KEY_ITEMS)
                viewModel?.initViewModel(category, itemsNum)
            }
        }

        viewModel?.currentItem?.observe(this, Observer {item ->

            val playAnimation = AtomicBoolean(true)

            val imageToShow = if(img_picture1.alpha == 1f) img_picture2 else img_picture1
            val imageToHide = if(img_picture1.alpha == 1f) img_picture1 else img_picture2

            Picasso.get().load(item.images.first()).noFade().into(imageToShow, object : Callback {
                override fun onSuccess() {
                    imageToShow.animate().alpha(1f).setInterpolator(AccelerateInterpolator()).setDuration(1000L).start()
                    imageToHide.animate().alpha(0f).setInterpolator(AccelerateInterpolator()).setDuration(1000L).start()
                }

                override fun onError(e: Exception?) {
                }
        })
        })

        viewModel?.nextItem?.observe(this, Observer {item ->
            Picasso.get().load(item.images.first())
        })

        viewModel?.currentItemAnswers?.observe(this,Observer {answers ->
            btn_answer1.text = answers[0].name.cs
            btn_answer2.text = answers[1].name.cs
            btn_answer3.text = answers[2].name.cs
            btn_answer4.text = answers[3].name.cs
        })

        btn_answer1.onClick { viewModel?.selectAnswer(0) }
        btn_answer2.onClick { viewModel?.selectAnswer(1) }
        btn_answer3.onClick { viewModel?.selectAnswer(2) }
        btn_answer4.onClick { viewModel?.selectAnswer(3) }

        viewModel?.selectedAndCorrectAnswerIndex?.observe(this,Observer { idx ->

            if(idx.first != -1) {

                val selectedBtn = when(idx.first) {
                    0 -> btn_answer1
                    1 -> btn_answer2
                    2 -> btn_answer3
                    3 -> btn_answer4
                    else -> btn_answer4
                }

                val drawable = TransitionDrawable(arrayOf(ContextCompat.getDrawable(context!!, cz.dodo.memorizer.R.drawable.selector_button_answer),
                        ContextCompat.getDrawable(context!!, cz.dodo.memorizer.R.drawable.selector_button_answer_selected)))
                selectedBtn.background = drawable
                drawable.startTransition(500)

                GlobalScope.launch(context = Dispatchers.Main) {
                    delay(500)

                    if(idx.first != idx.second) {
                        // highlight correct and error

                        val correctBtn = when(idx.second) {
                            0 -> btn_answer1
                            1 -> btn_answer2
                            2 -> btn_answer3
                            3 -> btn_answer4
                            else -> btn_answer4
                        }

                        var drawable = TransitionDrawable(arrayOf(ContextCompat.getDrawable(context!!, cz.dodo.memorizer.R.drawable.selector_button_answer_selected),
                                ContextCompat.getDrawable(context!!, cz.dodo.memorizer.R.drawable.selector_button_answer_error)))
                        selectedBtn.background = drawable
                        drawable.startTransition(500)

                        drawable = TransitionDrawable(arrayOf(ContextCompat.getDrawable(context!!, cz.dodo.memorizer.R.drawable.selector_button_answer),
                                ContextCompat.getDrawable(context!!, cz.dodo.memorizer.R.drawable.selector_button_answer_correct)))
                        correctBtn.background = drawable
                        drawable.startTransition(500)


                    } else {
                        var drawable = TransitionDrawable(arrayOf(ContextCompat.getDrawable(context!!, cz.dodo.memorizer.R.drawable.selector_button_answer_selected),
                                ContextCompat.getDrawable(context!!, cz.dodo.memorizer.R.drawable.selector_button_answer_correct)))
                        selectedBtn.background = drawable
                        drawable.startTransition(500)
                    }

                    delay(1000)
                    // start image transition
                    if(viewModel?.gotoNext() !== true) {

                    } else {
                        btn_answer1.background = ContextCompat.getDrawable(context!!, R.drawable.selector_button_answer)
                        btn_answer2.background = ContextCompat.getDrawable(context!!, R.drawable.selector_button_answer)
                        btn_answer3.background = ContextCompat.getDrawable(context!!, R.drawable.selector_button_answer)
                        btn_answer4.background = ContextCompat.getDrawable(context!!, R.drawable.selector_button_answer)
                    }
                }
            }
        })


        if (savedInstanceState == null) {
            viewModel?.gotoNext()
        }
    }
}