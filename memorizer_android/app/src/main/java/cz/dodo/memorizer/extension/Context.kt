package cz.dodo.memorizer.extension

import android.content.Context
import android.graphics.drawable.Drawable
import android.os.Build
import android.os.Bundle
import android.util.TypedValue
import androidx.annotation.ColorInt
import androidx.annotation.ColorRes
import androidx.annotation.DimenRes
import androidx.annotation.DrawableRes
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment

inline fun <reified T : Fragment> T.withArguments(args: Bundle): T {
    this.arguments = args
    return this
}

/**
 * Extension function on [Context] that uses compat method for color retrieving
 */
@ColorInt
fun Context.getColorCompat(@ColorRes color: Int): Int {
    return ContextCompat.getColor(this, color)
}

@ColorInt
fun Fragment.getColorCompat(@ColorRes color: Int): Int = context!!.getColorCompat(color)


/**
 * Extension function on [Context] that uses compat method for color retrieving
 */
fun Context.getDrawableCompat(@DrawableRes drawable: Int): Drawable? {
    return ContextCompat.getDrawable(this, drawable)
}

fun Fragment.getDrawableCompat(@DrawableRes drawable: Int): Drawable? = context!!.getDrawableCompat(drawable)


/**
 * Extension to context that retrieves drawable from attribute
 */
fun Context.attributeDrawable(value: Int): Drawable? {
    val a = theme.obtainStyledAttributes(intArrayOf(value))
    val attributeResourceId = a.getResourceId(0, 0)
    a.recycle()
    return ContextCompat.getDrawable(this, attributeResourceId)
}

fun Fragment.attributeDrawable(value: Int): Drawable? = context!!.attributeDrawable(value)

/**
 * Extension that returns TypedValue from attribute
 */
fun Context.attribute(value: Int): TypedValue {
    val ret = TypedValue()
    theme.resolveAttribute(value, ret, true)
    return ret
}

fun Fragment.attribute(value: Int): TypedValue = context!!.attribute(value)

fun Context.attrAsDimen(value: Int): Int {
    return TypedValue.complexToDimensionPixelSize(attribute(value).data, resources.displayMetrics)
}

fun Fragment.attrAsDimen(value: Int): Int = context!!.attrAsDimen(value)

fun Context.dimenAsPx(@DimenRes value: Int): Int {
    return resources.getDimensionPixelOffset(value)
}

fun Fragment.dimenAsPx(@DimenRes value: Int): Int = context!!.dimenAsPx(value)

inline fun doBelowSdk(version: Int, f: () -> Unit) {
    if (Build.VERSION.SDK_INT < version) f()
}

inline fun doFromSdk(version: Int, f: () -> Unit) {
    if (Build.VERSION.SDK_INT >= version) f()
}
