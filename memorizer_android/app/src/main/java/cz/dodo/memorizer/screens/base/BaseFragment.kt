package cz.dodo.memorizer.screens.base

import android.app.ActionBar
import android.os.Build
import android.os.Bundle
import android.view.*
import android.widget.TextView
import android.widget.Toolbar
import androidx.annotation.ColorRes
import androidx.annotation.StringRes
import androidx.core.content.ContextCompat
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import cz.dodo.memorizer.R
import cz.dodo.memorizer.services.SharedPrefService
import kotlinx.android.synthetic.main.activity_fragment_base.*
import javax.inject.Inject

abstract class BaseFragment : androidx.fragment.app.Fragment() {

    @Inject
    lateinit var sharedPrefService: SharedPrefService

    abstract val shouldHaveActionBar: Boolean
    private var actionBarBackIcon = 0
    private var actionBarColor = 0
    private var actionBarTitleColor = 0

    abstract val layoutId: Int

    @Inject
    lateinit var viewModelFactory: ViewModelProvider.Factory

    open val title: String
        get() = ""


    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(layoutId, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        sharedPrefService.getLanguageCodeReactive().observe(this, Observer {langCode ->
            view.requestLayout()
        })
    }

    open fun onBackPressed(): Boolean = false

    override fun onResume() {
        super.onResume()
        setTitle(title)
        onInitActionBar((activity as BaseFragmentActivity).actionBar)
    }

    protected fun setTitle(@StringRes title: Int) {
        setTitle(getString(title))
    }

    protected fun setTitle(title: String?) {
        // we want to crash an app when activity is null since we are probably doing something bad
        activity!!.toolbar_title?.text = title
        activity!!.title = ""
    }

    open fun onInitActionBar(actionBar: ActionBar?) {
        // override where needed
        actionBar?.setHomeButtonEnabled(true)
        actionBar?.setDisplayHomeAsUpEnabled(true)
        initActionBarValues()
        showHideActionBar()
    }

    /**
     * Init action bar colors
     */
    open fun initActionBarValues(actionBarBackIcon: Int = R.drawable.ic_arrow_back,
                                 actionBarColor: Int = R.color.colorHeader,
                                 actionBarTitleColor: Int = R.color.white) {
        this.actionBarBackIcon = actionBarBackIcon
        this.actionBarColor = actionBarColor
        this.actionBarTitleColor = actionBarTitleColor
    }

    /**
     * Show/Hide action bar
     */
    open fun showHideActionBar() {
        if (shouldHaveActionBar) {
            (activity as BaseFragmentActivity).actionBar?.show()
            activity?.findViewById<TextView>(R.id.toolbar_title)?.setTextColor(ContextCompat.getColor(context!!, actionBarTitleColor))
            activity?.findViewById<Toolbar>(R.id.toolbar)?.setBackgroundColor(ContextCompat.getColor(context!!, actionBarColor))
            activity?.findViewById<Toolbar>(R.id.toolbar)?.setNavigationIcon(actionBarBackIcon)
            changeStatusBarColor(ContextCompat.getColor(context!!, R.color.colorStatusBar))
        } else {
            (activity as BaseFragmentActivity).actionBar?.hide()
        }
    }

    /**
     * Change status bar color
     */
    private fun changeStatusBarColor(color: Int) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val window = activity?.window
            window?.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
            window?.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
            window?.statusBarColor = color
        }
    }


    protected fun finish() {
        if (fragmentManager != null && fragmentManager!!.backStackEntryCount > 0) {
            fragmentManager?.popBackStack()
        } else {
            activity?.finish()
        }
    }

    fun updateStatusBarColor(@ColorRes color: Int) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            activity?.window?.let {
                it.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
                it.statusBarColor = activity?.resources!!.getColor(color)
            }
        }
    }
}