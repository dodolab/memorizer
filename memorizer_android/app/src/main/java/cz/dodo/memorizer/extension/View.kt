package cz.dodo.memorizer.extension

import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.view.View
import android.widget.EditText
import android.widget.ImageView
import androidx.annotation.ColorRes
import androidx.annotation.StringRes
import com.squareup.picasso.Picasso
import cz.dodo.memorizer.main.BaseFragment
import cz.dodo.memorizer.main.BaseFragmentActivity


/**
 * ImageView extension that loads url with Picasso
 */
fun ImageView.loadUrl(url: String?) {
    Picasso.get().load(url).into(this)
}

var View.show: Boolean
    get() = visibility == View.VISIBLE
    set(value) {
        visibility = if (value) View.VISIBLE else View.GONE
    }

fun View.string(@StringRes res: Int): String {
    return context.getString(res)
}

/**
 * Get color from resource
 */
fun View.color(@ColorRes res: Int): Int {
    return context.getColorCompat(res)
}

/**
 * Get color as shade of gray
 */
fun View.colorShadeOfGray(shadePercent: Int): Int {
    return Color.rgb((shadePercent / 100f * 0xFF).toInt(), (shadePercent / 100f * 0xFF).toInt(), (shadePercent / 100f * 0xFF).toInt())
}

/**
 * Get color from resources with alpha
 */
fun View.colorWithAlpha(@ColorRes res: Int, alphaPrecent: Int): Int {
    val color = context.getColorCompat(res)
    return Color.argb((alphaPrecent / 100f * 255).toInt(), Color.red(color), Color.green(color), Color.blue(color))
}

/**
 * Set text to edittext when text is different
 * Useful especially for subscribed events when we want to fire the event
 * if and only if the text has changed
 */
fun EditText.setTextIfNotSame(text: String?) {
    if (!text.equals(this.text.toString())) {
        setText(text)
    }
}

fun View.onClick(l: ((View) -> Unit)) {
    setOnClickListener(l)
}



inline fun <reified T : BaseFragment> BaseFragment.startFragmentActivityClearTop(args: Bundle) {
    val intent = Intent(context, BaseFragmentActivity::class.java).putExtra(BaseFragmentActivity.EXTRA_FRAGMENT_NAME, T::class.java.name)
    intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK or Intent.FLAG_ACTIVITY_NEW_TASK)
    intent.putExtra(BaseFragmentActivity.EXTRA_ARGUMENTS, args)
    context?.startActivity(intent)
}

inline fun <reified T : BaseFragment> BaseFragment.startFragmentActivity() {
    BaseFragmentActivity.startActivity(context!!, T::class.java.name)
}

inline fun <reified T : BaseFragment> BaseFragment.startFragmentActivity(args: Bundle) {
    BaseFragmentActivity.startActivity(context!!, T::class.java.name, args)
}

inline fun <reified T : BaseFragment> BaseFragment.startFragmentActivityForResult(requestCode: Int) {
    BaseFragmentActivity.startActivityForResult(context!!, T::class.java.name, BaseFragmentActivity::class.java, requestCode)
}

inline fun <reified T : BaseFragment> BaseFragment.startFragmentActivityForResult(requestCode: Int, args: Bundle) {
    BaseFragmentActivity.startActivityForResult(context!!, T::class.java.name, BaseFragmentActivity::class.java, requestCode, args)
}