package cz.dodo.memorizer.screens

import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.LiveData
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.RecyclerView
import com.squareup.picasso.Picasso
import cz.dodo.memorizer.R
import cz.dodo.memorizer.entities.Category
import kotlinx.android.synthetic.main.fragment_categories.*
import kotlinx.android.synthetic.main.item_category_grid.view.*
import kotlinx.android.synthetic.main.item_general.view.*

enum class CategoriesMode {
    LIST,
    GRID
}

class CategoriesAdapter (
        private val items: List<Category>,
        private val onCategoryClick: OnCategoryClick,
        var langCode: LiveData<String>,
        private val catMode: CategoriesMode
) : RecyclerView.Adapter<CategoriesAdapter.ViewHolder>() {

    interface OnCategoryClick {
        fun performCategoryClick(category: Category)
    }



    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val layout = if(catMode == CategoriesMode.GRID) R.layout.item_category_grid else R.layout.item_general
        return ViewHolder(LayoutInflater.from(parent.context).inflate(layout, parent, false))
    }


    override fun getItemCount() = items.size

    fun getItem(index: Int): Category = items[index]

    override fun onBindViewHolder(holder: ViewHolder, position: Int) =
            holder.bindViewHolder(items, position, holder.itemViewType, langCode.value!!, catMode, onCategoryClick)

    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        fun bindViewHolder(items: List<Category>, position: Int, viewType: Int, langCode: String,
                           catMode: CategoriesMode, onCategoryClick: OnCategoryClick) {

            val item = items[position]

            if(catMode == CategoriesMode.LIST) {
                itemView.txt_name.text = item.name.getLocString(langCode)
                itemView.card_view.setOnClickListener {
                    onCategoryClick.performCategoryClick(item)
                }
                Picasso.get().load(item.items.first().images.first()).into(itemView.img_category)
            } else {
                itemView.txt_category.text = item.name.getLocString(langCode)
                itemView.card_view_grid.setOnClickListener {
                    onCategoryClick.performCategoryClick(item)
                }
                Picasso.get().load(item.items.first().images.first()).into(itemView.img_category_grid)
            }
        }
    }
}