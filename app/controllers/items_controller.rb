class ItemsController < ApplicationController

before_action :category_parent_array, only: [:new, :create, :edit]
before_action :set_item, only: [:show, :edit, :update, :destroy]
before_action :show_all_instance, only: [:show, :edit, :destroy]
  
  def index
    @items_category = Item.where("buyer_id IS NULL AND trading_status = 0 AND category_id < 200").order(created_at: "DESC")
    @items_brand = Item.where("buyer_id IS NULL AND  trading_status = 0 AND brand_id = 1").order(created_at: "DESC")
  end

  def new
    @item = Item.new
    @item.item_imgs.new
    # @category_parent =  Category.where("ancestry is null")
  end

  # 親カテゴリーが選択された後に動くアクション
  def category_children
    @category_children = Category.find("#{params[:parent_id]}").children
    #親カテゴリーに紐付く子カテゴリーを取得
  end

  # 子カテゴリーが選択された後に動くアクション
  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
    #子カテゴリーに紐付く孫カテゴリーの配列を取得
  end

  def create
    @item = Item.new(item_params)
    
    unless @item.valid?
      @item.item_imgs.new
      render :new and return
    end
    
    @item.save
    redirect_to root_path
  end

  def edit
    grandchild = @item.category
    child = grandchild.parent
    if @category_id == 46 or @category_id == 74 or @category_id == 134 or @category_id == 142 or @category_id == 147 or @category_id == 150 or @category_id == 158
    else
     @parent_array = []
     @parent_array << @item.category.parent.parent.name
     @parent_array << @item.category.parent.parent.id
    end
     @category_children_array = Category.where(ancestry: child.ancestry)
     @child_array = []
     @child_array << child.name
     @child_array << child.id

     @category_grandchildren_array = Category.where(ancestry: grandchild.ancestry)
     @grandchild_array = []
     @grandchild_array << grandchild.name
     @grandchild_array << grandchild.id

  end

  def update
    if item_params[:images_attributes].nil?
      flash.now[:alert] = '更新できませんでした 【画像を１枚以上入れてください】'
      render :edit
    else
      exit_ids = []
      item_params[:images_attributes].each do |a,b|
        exit_ids << item_params[:images_attributes].dig(:"#{a}",:id).to_i
      end
      ids = Image.where(item_id: params[:id]).map{|image| image.id }
      delete__db = ids - exit_ids
      Image.where(id:delete__db).destroy_all
      @item.touch
      if @item.update(item_params)
        redirect_to  update_done_items_path
      else
        flash.now[:alert] = '更新できませんでした'
        render :edit
      end
    end
  end

  def update_done
    @item_update = Item.order("updated_at DESC").first
  end


  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :prefecture_code, :brand_id, :pref_id, :size_id, :item_condition_id, :postage_payer_id, :preparation_day_id, :postage_type_id, :category_id, :trading_status, item_imgs_attributes: [:url, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def category_parent_array
    @category_parent_array = Category.where(ancestry: nil).each do |parent|
    end
  end

  def show_all_instance
    @user = User.find(@item.user_id)
    @images = Image.where(item_id: params[:id])
    @images_first = Image.where(item_id: params[:id]).first
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
  end
end