package cz.dodo.memorizer.extension

import android.content.Intent
import android.os.Bundle
import android.view.View
import cz.dodo.memorizer.screens.base.BaseFragment
import cz.dodo.memorizer.screens.base.BaseFragmentActivity

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