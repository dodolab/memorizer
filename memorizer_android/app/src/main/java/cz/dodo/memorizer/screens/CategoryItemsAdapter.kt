package cz.dodo.memorizer.screens

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.squareup.picasso.Picasso
import cz.dodo.memorizer.R
import cz.dodo.memorizer.entities.SpeciesItem
import kotlinx.android.synthetic.main.item_general.view.*

class CategoryItemsAdapter (
        private val items: List<SpeciesItem>,
        private val onItemClick: OnItemClick
) : RecyclerView.Adapter<CategoryItemsAdapter.ViewHolder>() {

    interface OnItemClick {
        fun performItemClick(item: SpeciesItem)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.item_general, parent, false))
    }

    override fun getItemCount() = items.size

    fun getItem(index: Int): SpeciesItem = items[index]

    override fun onBindViewHolder(holder: ViewHolder, position: Int) =
            holder.bindViewHolder(items, position, holder.itemViewType, onItemClick)

    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        fun bindViewHolder(items: List<SpeciesItem>, position: Int, viewType: Int, onItemClick: OnItemClick) {

            val item = items[position]

            itemView.txt_name.text = item.name.cs
            itemView.card_view.setOnClickListener {
                onItemClick.performItemClick(item)
            }

            Picasso.with(itemView.context).isLoggingEnabled =true
            Picasso.with(itemView.context).load(item.images.first()).into(itemView.img_category)
        }
    }
}