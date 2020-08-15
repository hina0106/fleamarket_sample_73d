class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :destroy]
  before_action :set_condition, only: [:show, :edit, :change_status]
  before_action :set_delivery, only: [:show, :edit, :change_status]
  before_action :set_user, only: [:show, :edit, :change_status]
  before_action :set_category, except:[:show,:destroy,:index]
  
  def index
    @items = Item.limit(10).order('created_at DESC')
    @items_category = Item.where("buyer_id IS NULL AND trading_status = 0 AND category_id < 200").order(created_at: "DESC")
    @items_brand = Item.where("buyer_id IS NULL AND  trading_status = 0 AND brand_id = 1").order(created_at: "DESC")
  end

  def new
    @item = Item.new
    @item.item_imgs.new
    category_parent = Category.where(ancestry: nil)
    # 親カテゴリーが選択された後に動くアクション
    def get_category_child
      @category_child = Category.find("#{params[:parent_id]}").children
      render json: @category_child
      #親カテゴリーに紐付く子カテゴリーを取得
    end

    # 子カテゴリーが選択された後に動くアクション
    def get_category_grandchild
      @category_grandchild = Category.find("#{params[:child_id]}").children
      render json: @category_grandchild
      #子カテゴリーに紐付く孫カテゴリーの配列を取得
    end
  end

  def show
    @comment = Comment.new
    @comments = Comment.where(item_id: @item.id)
    @parents = Category.all.order("id ASC").limit(1000) 
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path  
    else
      redirect_to new_item_path unless @item.valid?    
    end
  end

  def edit
    def get_category_child
      @category_child = Category.find(params[:parent_id]).children
      render json: @category_child
    end
  
    def get_category_grandchild
      @category_grandchild = Category.find(params[:child_id]).children
      render json: @category_grandchild
    end
  end

  def update
    if item.user_id == current_user.id && item.update(items_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    if @item.user_id == current_user.id && @item.destroy
      redirect_to edit_sell_path #仮のpath
    else
      redirect_to root_path #仮のpath
    end
  end


  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :prefecture_code, :brand_id, :pref_id, :size_id, :item_condition_id, :postage_payer_id, :preparation_day_id, :postage_type_id, :category_id, :trading_status, item_imgs_attributes: [:url, :id]).merge(seller_id: current_user.id)
  end

  # 商品情報
  def set_item
    @item = Item.find(params[:id])
  end

  def set_user
    @user = User.find(@item.seller_id)
  end

  def correct_user
    @item = Item.find(params[:id])
    if @item.user_id != current_user.id
      redirect_to root_path
    end
  end

  # 商品状態
  def set_condition
    @condition = ItemCondition.find(@item.item_condition_id)
  end

  # 発送日目安、配送方法、配送料の負担
  def set_delivery
    @delivery_charge = PostagePayer.find(@item.postage_payer_id)
    @delivery_way = PostageType.find(@item.postage_type_id)
    @delivery_days = PreparationDay.find(@item.preparation_day_id)
  end

  def set_category
    @category_parent = Category.where(ancestry: nil)
  end

end
