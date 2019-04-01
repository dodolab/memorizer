package cz.dodo.memorizer.main

import android.widget.SeekBar
import androidx.appcompat.widget.AppCompatSeekBar
import androidx.databinding.BindingAdapter
import androidx.databinding.InverseBindingAdapter
import androidx.databinding.InverseBindingListener


@BindingAdapter("currentValueAttrChanged")
fun setListener(view: com.mohammedalaa.seekbar.RangeSeekBarView, listener: InverseBindingListener?) {
    if (listener != null) {
        view.setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
            override fun onStartTrackingTouch(p0: SeekBar?) {

            }

            override fun onStopTrackingTouch(p0: SeekBar?) {
            }

            override fun onProgressChanged(p0: SeekBar?, p1: Int, p2: Boolean) {
                view.onProgressChanged(p0, p1, p2)
                listener.onChange()
            }

        })
    }
}


@BindingAdapter("app:currentValue")
fun setCurrentValue(view: com.mohammedalaa.seekbar.RangeSeekBarView, currentVaue: Int) {
    view.value = currentVaue
}

@InverseBindingAdapter(attribute = "app:currentValue")
fun getCurrentValue(view: com.mohammedalaa.seekbar.RangeSeekBarView): Int {
    return view.value
}