package cz.dodo.memorizer.screens

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.squareup.picasso.Picasso
import cz.dodo.memorizer.R
import cz.dodo.memorizer.entities.Category
import kotlinx.android.synthetic.main.item_category_grid.view.*

class CategoriesGridAdapter (
        private val items: List<Category>,
        private val onCategoryClick: OnCategoryClick
) : RecyclerView.Adapter<CategoriesGridAdapter.ViewHolder>() {

    interface OnCategoryClick {
        fun performCategoryClick(category: Category)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.item_category_grid, parent, false))
    }

    override fun getItemCount() = items.size

    fun getItem(index: Int): Category = items[index]

    override fun onBindViewHolder(holder: ViewHolder, position: Int) =
            holder.bindViewHolder(items, position, holder.itemViewType, onCategoryClick)

    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        fun bindViewHolder(items: List<Category>, position: Int, viewType: Int, onCategoryClick: OnCategoryClick) {

            val item = items[position]

            itemView.txt_category.text = item.name.cs
            itemView.card_view.setOnClickListener {
                onCategoryClick.performCategoryClick(item)
            }

            Picasso.with(itemView.context).isLoggingEnabled =true
            Picasso.with(itemView.context).load(item.items.first().images.first()).into(itemView.img_category)
        }
    }
}