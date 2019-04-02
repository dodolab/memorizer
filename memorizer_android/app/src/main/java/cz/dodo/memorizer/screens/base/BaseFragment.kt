package cz.dodo.memorizer.screens.base

import android.app.ActionBar
import android.graphics.Rect
import android.os.Build
import android.os.Bundle
import android.view.*
import android.widget.TextView
import android.widget.Toolbar
import androidx.annotation.ColorRes
import androidx.annotation.StringRes
import androidx.core.content.ContextCompat
import androidx.lifecycle.ViewModelProvider
import com.google.android.material.snackbar.Snackbar
import cz.dodo.memorizer.R
import kotlinx.android.synthetic.main.activity_fragment_base.*
import javax.inject.Inject

abstract class BaseFragment : androidx.fragment.app.Fragment() {

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

    open fun onBackPressed(): Boolean = false


    fun showSnack(resId: Int) {
        showSnack(getString(resId))
    }

    fun showSnack(message: String) {
        if (view != null) {
            Snackbar.make(view!!, message, Snackbar.LENGTH_LONG).show()
        }
    }

    override fun onResume() {
        super.onResume()
        setTitle(title)
        onInitActionBar((activity as BaseFragmentActivity).actionBar)
        showHideKeyboard()
    }

    protected fun setTitle(@StringRes title: Int) {
        setTitle(getString(title))
    }

    protected fun setTitle(title: String?) {
        // we want to crash an app when activity is null since we are probably doing something bad
        activity!!.toolbar_title?.text = title
        activity!!.title = ""
    }

    override fun onDestroyView() {
        super.onDestroyView()
        // TODO destroy all observers of the network state
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
                                 actionBarColor: Int = R.color.colorPrimary,
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
            changeStatusBarColor(ContextCompat.getColor(context!!, actionBarColor))
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

    /**
     * Show keyboard or hide it
     * Showing keyboard if shouldShowKeyboard is true, otherwise hide it
     *
     * @param shouldShowKeyboard
     */
    open fun showHideKeyboard(shouldShowKeyboard: Boolean = false) {
        if (shouldShowKeyboard) {
            showKeyboard()
        } else {
            hideKeyboard()
        }
    }

    /**
     * Hide Keyboard
     */
    private fun hideKeyboard() =
            activity?.window?.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN)

    /**
     * Show Keyboard
     */
    private fun showKeyboard() =
            activity?.window?.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE)

    protected fun scrollToView(view: View, padding: Int = 0) {
        view.post { view.requestRectangleOnScreen(Rect(0, padding, view.width, view.height)) }
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
