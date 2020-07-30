class ItemsController < ApplicationController
  
  def index
    @items = Item.limit(10).order('created_at DESC')
  end

  def new
    @item = Item.new
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

  def show
    @item = Item.find(params[:id])
    # @sub2_category = Sub2Category.includes(sub_category: :main_category).find(@item.category)
    # @images = @item.images
    # @image = @images.first
    # @comment = Comment.new
    # @comments = Comment.where(product_id: @product.id)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path

    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if item.user_id == current_user.id
      item.update(items_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    if @item.user_id == current_user.id
      @item.destroy
      redirect_to edit_sell_path #仮のpath
    else
      redirect_to root_path #仮のpath
    end
  end


    private

  def item_params
    params.require(:item).permit(:name, :text, :category, :price, :status, :deliverycost, :pref, :delivery_days, images: []).merge(user_id: current_user.id)
  end

  def set_product
    @item = Item.find(params[:id])
  end

  def set_user
    @user = User.find(@item.user_id)
  end

  def correct_user
    @item = Item.find(params[:id])
    if @item.user_id != current_user.id
      redirect_to root_path
    end
  end

end