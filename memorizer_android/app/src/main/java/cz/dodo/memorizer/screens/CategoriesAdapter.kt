package cz.dodo.memorizer.screens

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import cz.dodo.memorizer.R
import cz.dodo.memorizer.entities.Category

class CategoriesAdapter (
        private val items: List<Category>,
        private val onCategoryClick: OnCategoryClick
) : RecyclerView.Adapter<CategoriesAdapter.ViewHolder>() {

    interface OnCategoryClick {
        fun performCategoryClick(category: Category)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.item_category, parent, false))
    }

    override fun getItemCount() = items.size

    fun getItem(index: Int): Category = items[index]

    override fun onBindViewHolder(holder: ViewHolder, position: Int) =
            holder.bindViewHolder(items, position, holder.itemViewType, onCategoryClick)

    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        fun bindViewHolder(items: List<Category>, position: Int, viewType: Int, onCategoryClick: OnCategoryClick) {
            /*itemView.txt_station_name_departure.text = segment.path.firstOrNull()?.startTitle
            itemView.layout_line_detail.onClick {
                onLineDetailClick.performOnLineDetailClick(segment)
            } */
        }

    }
}