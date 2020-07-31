class ItemsController < ApplicationController

  def index
    @parents = Category.where(ancestry: nil)
  end

  def new
    @item = Item.new
    @item.images.build
    def get_category_child
      @category_child = Category.find(params[:parent_id]).children
      render json: @category_child
    end
  
    def get_category_grandchild
      @category_grandchild = Category.find(params[:child_id]).children
      render json: @category_grandchild
    end
  end

  def create
    @item = Item.new(item_params) 
    if @item.save
      redirect_to root_path
    else 
      redirect_to new_item_path
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

  def show
    @prefectures = Prefecture.all
  end

  def update
    if @item.update(item_params)
      redirect_to item_path, notice: '変更しました！'
   else
    redirect_to edit_item_path(@item)
   end
  end

  def destroy
    if @item.destroy 
       redirect_to root_path, notice: '削除しました！'
    else
      render :show
    end
  end

 private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name,:price,:introduction,:bland,:prefecture_name,:condition_id,
    :postage_payer,:preparation_day,:category_id,images_attributes:[:url,:_destroy, :id]).merge(seller_id:current_user.id)
  end

  def set_category
    @category_parent = Category.where(ancestry: nil)
  end

  def move_to_sign_in
    redirect_to new_user_session_path unless user_signed_in?
  end
end
