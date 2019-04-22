package cz.dodo.memorizer.extension

import android.content.Context
import android.graphics.drawable.Drawable
import android.os.Build
import androidx.annotation.ColorInt
import androidx.annotation.ColorRes
import androidx.annotation.DrawableRes
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment


@ColorInt
fun Context.getColorCompat(@ColorRes color: Int): Int {
    return ContextCompat.getColor(this, color)
}

@ColorInt
fun Fragment.getColorCompat(@ColorRes color: Int): Int = context!!.getColorCompat(color)


fun Context.getDrawableCompat(@DrawableRes drawable: Int): Drawable? {
    return ContextCompat.getDrawable(this, drawable)
}

fun Fragment.getDrawableCompat(@DrawableRes drawable: Int): Drawable? = context!!.getDrawableCompat(drawable)


inline fun doBelowSdk(version: Int, f: () -> Unit) {
    if (Build.VERSION.SDK_INT < version) f()
}

inline fun doFromSdk(version: Int, f: () -> Unit) {
    if (Build.VERSION.SDK_INT >= version) f()
}
