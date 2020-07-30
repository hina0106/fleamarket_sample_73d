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
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path

    else
      render :new
    end
  end

    private

  def item_params
    params.require(:item).permit(:name, :text, :category, :price, :status, :deliverycost, :pref, :delivery_days, images: []).merge(user_id: current_user.id)
  end
end