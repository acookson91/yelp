class RestaurantsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    unless @restaurant.user == current_user
      flash[:notice] = 'That is not your Restaurant!'
      redirect_to '/restaurants'
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.user == current_user
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted sucessfully'
      redirect_to '/restaurants'
    else
      flash[:notice] = 'That is not your Restaurant!'
      redirect_to '/restaurants'
    end
  end
end
