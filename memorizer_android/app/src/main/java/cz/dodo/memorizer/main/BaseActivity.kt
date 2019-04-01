package cz.dodo.memorizer.main

import android.annotation.SuppressLint
import android.content.DialogInterface
import android.os.Bundle
import android.view.MenuItem
import android.view.View
import android.widget.FrameLayout
import androidx.annotation.StringRes
import androidx.appcompat.app.AlertDialog
import androidx.fragment.app.FragmentActivity
import com.google.android.material.snackbar.Snackbar
import cz.dodo.memorizer.R

open class BaseFragmentActivity : FragmentActivity() {

    var view: View? = null

    @SuppressLint("InflateParams")  // There is no parent view here, so we need to suppress this warning
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        view = layoutInflater.inflate(R.layout.activity_fragment_base, null)
        setContentView(view, FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT))
        setActionBar(findViewById(R.id.toolbar))
    }

    override fun onOptionsItemSelected(item: MenuItem?): Boolean {
        when (item?.itemId) {
            android.R.id.home -> onBackPressed()
        }
        return super.onOptionsItemSelected(item)
    }

    override fun onBackPressed() {
        // current implementation (Navigation component) allows only one fragment at a time
        val currentFragment = supportFragmentManager.fragments.firstOrNull()
        if (currentFragment == null || currentFragment !is BaseFragment || !currentFragment.onBackPressed()) {
            // TODO GO BACK
        }
    }

    companion object {
        const val CONTENT_VIEW_ID = R.id.fragment_container
        const val EXTRA_ARGUMENTS = "arguments"
    }

    fun showSnack(message: String) {
        Snackbar.make(findViewById(android.R.id.content), message, Snackbar.LENGTH_SHORT).show()
    }

    fun showSnack(@StringRes resId: Int) {
        showSnack(getString(resId))
    }

    fun showErrorDialog(message: String, onClickListener: DialogInterface.OnClickListener? = null) {
        val alertDialog = AlertDialog.Builder(this)
                .setTitle("Error")
                .setMessage(message)
                .setNeutralButton("OK", onClickListener)
                .create()
        alertDialog.show()
    }
}