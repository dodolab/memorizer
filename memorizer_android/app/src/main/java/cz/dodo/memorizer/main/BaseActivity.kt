package cz.dodo.memorizer.main

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.DialogInterface
import android.content.Intent
import android.os.Bundle
import android.view.MenuItem
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.annotation.StringRes
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.widget.Toolbar
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import androidx.fragment.app.FragmentTransaction
import com.google.android.material.snackbar.Snackbar
import android.widget.SimpleAdapter
import cz.dodo.memorizer.MemorizerApp
import cz.dodo.memorizer.R
import cz.dodo.memorizer.extension.onClick
import kotlinx.android.synthetic.main.activity_fragment_base.*
import javax.inject.Inject


open class BaseFragmentActivity : FragmentActivity() {

    @Inject
    lateinit var sharedPrefService: SharedPrefService

    var view: View? = null

    @SuppressLint("InflateParams")  // There is no parent view here, so we need to suppress this warning
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MemorizerApp.getAppComponent(application).inject(this)
        view = layoutInflater.inflate(R.layout.activity_fragment_base, null)
        setContentViewInternal(view, FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT))
        setActionBar(findViewById(R.id.toolbar))

        img_flag.onClick {
            showFlagPicker()
        }

        val fragmentName = getFragmentName()
        val args = intent.getBundleExtra(EXTRA_ARGUMENTS)

        var fragment: Fragment? = supportFragmentManager.findFragmentByTag(fragmentName)
        if (fragment == null && savedInstanceState == null) {
            fragment = instantiateFragment(fragmentName)
            if (args != null) {
                fragment.arguments = args
            }
            supportFragmentManager.beginTransaction().add(CONTENT_VIEW_ID, fragment, fragment.javaClass.name).commit()
        }
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
            super.onBackPressed()
        }
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


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (currentFragment != null) {
            currentFragment!!.onActivityResult(requestCode, resultCode, data)
        }
    }


    fun replaceFragment(fragment: Fragment, addToBackStack: Boolean) {
        replaceFragment(fragment, fragment.javaClass.name, addToBackStack)
    }

    @JvmOverloads fun replaceFragment(fragment: Fragment, name: String = fragment.javaClass.name, addToBackStack: Boolean = true) {
        try {
            val transaction = supportFragmentManager.beginTransaction().replace(CONTENT_VIEW_ID, fragment, fragment.javaClass.name)
            if (addToBackStack) {
                transaction.addToBackStack(name)
            }

            transaction.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_OPEN).commit()
        } catch (e: Exception) {//java.lang.IllegalStateException: Can not perform this action after onSaveInstanceState
            e.printStackTrace()
        }

    }

    protected fun instantiateFragment(fragmentName: String): Fragment {
        return Fragment.instantiate(this, fragmentName)
    }

    protected fun setContentViewInternal(view: View?, params: ViewGroup.LayoutParams) {
        setContentView(view, params)
    }

    public val toolbar: Toolbar?
        get() = findViewById(R.id.toolbar) as Toolbar

    val currentFragment: Fragment?
        get() = supportFragmentManager.findFragmentById(CONTENT_VIEW_ID)

    /**
     * Returns the name of the fragment to be instantiated.

     * Note: IF you will NOT override this function, the activity is immediately finished

     * @return name of fragment class
     */
    open fun getFragmentName(): String = intent.getStringExtra(EXTRA_FRAGMENT_NAME)


    fun showFlagPicker() {

        // Each image in array will be displayed at each item beginning.
        val imageIdArr = intArrayOf(R.drawable.flag_cs, R.drawable.flag_en, R.drawable.flag_la)
        // Each item text.
        val listItemArr = arrayOf("Česky", "English", "Latin")

        // Image and text item data's key.
        val CUSTOM_ADAPTER_IMAGE = "image"
        val CUSTOM_ADAPTER_TEXT = "text"


        // Create a alert dialog builder.
        val builder = AlertDialog.Builder(this)
        // Set icon value.
        builder.setIcon(R.mipmap.ic_launcher)
        // Set title value.
        builder.setTitle("Select language")

        // Create SimpleAdapter list data.
        val dialogItemList = ArrayList<Map<String, Any>>()
        val listItemLen = listItemArr.size
        for (i in 0 until listItemLen) {
            val itemMap = HashMap<String, Any>()
            itemMap[CUSTOM_ADAPTER_IMAGE] = imageIdArr[i]
            itemMap[CUSTOM_ADAPTER_TEXT] = listItemArr[i]

            dialogItemList.add(itemMap)
        }

        // Create SimpleAdapter object.
        val simpleAdapter = SimpleAdapter(this, dialogItemList,
                R.layout.item_flag,
                arrayOf(CUSTOM_ADAPTER_IMAGE, CUSTOM_ADAPTER_TEXT),
                intArrayOf(R.id.txt_flag, R.id.txt_text))

        // Set the data adapter.
        builder.setAdapter(simpleAdapter) { dialogInterface, itemIndex ->
            when(itemIndex) {
                0 -> selectLanguage("cs")
                1 -> selectLanguage("en")
                2 -> selectLanguage("la")
            }
        }
        builder.setCancelable(false)
        builder.create()
        builder.show()
    }

    fun selectLanguage(langCode: String) {

    }

    companion object {
        val TAG = "BaseFragmentActivity"
        val CONTENT_VIEW_ID = R.id.fragment_container
        val EXTRA_FRAGMENT_NAME = "fragment"
        val EXTRA_ARGUMENTS = "arguments"
        const val TOOLBAR_TYPE: String = "toolbar_type"

        fun generateIntent(ctx: Context, fragmentName: String): Intent {
            return Intent(ctx, BaseFragmentActivity::class.java).putExtra(EXTRA_FRAGMENT_NAME, fragmentName)
        }

        fun generateIntent(ctx: Context, fragmentName: String, args: Bundle): Intent {
            return generateIntent(ctx, fragmentName).putExtra(EXTRA_ARGUMENTS, args)
        }

        fun generateIntent(ctx: Context, fragmentName: String, args: Bundle, activityClass: Class<*>): Intent {
            return Intent(ctx, activityClass).putExtra(EXTRA_FRAGMENT_NAME, fragmentName).putExtra(EXTRA_ARGUMENTS, args)
        }

        fun startActivity(ctx: Context, fragmentName: String) {
            val intent = generateIntent(ctx, fragmentName)
            ctx.startActivity(intent)
        }

        fun startActivity(ctx: Context, fragmentName: String, activityClass: Class<*>) {
            val intent = Intent(ctx, activityClass).putExtra(EXTRA_FRAGMENT_NAME, fragmentName)
            ctx.startActivity(intent)
        }

        fun startActivityForResult(ctx: Context, fragmentName: String, activityClass: Class<*>, requestCode: Int) {
            val intent = Intent(ctx, activityClass).putExtra(EXTRA_FRAGMENT_NAME, fragmentName)
            if (ctx is Activity) {
                ctx.startActivityForResult(intent, requestCode)
            }
        }

        fun startActivityForResult(ctx: Context, fragmentName: String, activityClass: Class<*>, requestCode: Int, args: Bundle) {
            val intent = Intent(ctx, activityClass).putExtra(EXTRA_FRAGMENT_NAME, fragmentName).putExtra(EXTRA_ARGUMENTS, args)
            if (ctx is Activity) {
                ctx.startActivityForResult(intent, requestCode)
            }
        }

        fun startActivity(ctx: Context, fragmentName: String, activityClass: Class<*>, args: Bundle) {
            val intent = Intent(ctx, activityClass).putExtra(EXTRA_FRAGMENT_NAME, fragmentName).putExtra(EXTRA_ARGUMENTS, args)
            ctx.startActivity(intent)
        }

        fun startActivity(ctx: Context, fragmentName: String, args: Bundle) {
            ctx.startActivity(generateIntent(ctx, fragmentName, args))
        }

        fun startActivity(ctx: Context, fragmentName: String, extras: Intent) {
            val intent = Intent(ctx, BaseFragmentActivity::class.java).putExtra(EXTRA_FRAGMENT_NAME, fragmentName).putExtras(extras)
            ctx.startActivity(intent)
        }
    }
}