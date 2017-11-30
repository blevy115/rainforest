class ProductsController < ApplicationController
before_action :ensure_logged_in, except: [:show, :index]
before_action :load_product, only: [ :show, :edit, :update, :destroy]
before_action :ensure_user_owns_product, only: [:edit, :update, :destroy]

  def load_product
    @product = Product.find(params[:id])
  end

  def ensure_logged_in
    unless current_user
    flash[:alert] = "Please log in"
    redirect_to sessions_new_url
    end
  end

  def ensure_user_owns_product
    unless current_user == @product.user
      flash[:alert] = "You are not the owner of this product"
      redirect_to new_sessions_url
    end
  end

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new
    @product.name = params[:product][:name]
    @product.description = params[:product][:description]
    @product.price_in_cents = params[:product][:price_in_cents]
    @product.user = current_user

    if @product.save
      flash[:notice] = "product is successfully created!"
      redirect_to products_url
    else
    render :new
    end
  end



  def edit

  end

  def show

    @review = Review.new
  end

  def update

    @product.name = params[:product][:name]
    @product.description = params[:product][:description]
    @product.price_in_cents = params[:product][:price_in_cents]
    @product.user = current_user

    if @product.save
      flash[:notice] = "product is successfully updated!"
      redirect_to products_url
    else
      render :new
    end
  end


  def destroy

    @product.destroy
    flash[:notice] = "products deleted!"
    redirect_to root_url

  end


end
