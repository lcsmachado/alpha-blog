class CategoriesController < ApplicationController

  before_action :set_categories, only: [:edit, :update, :show, :destroy]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  
  def show

  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category created successfully"
      redirect_to @category
    else
      render 'new'
    end
  end

  private

  def set_categories
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

end