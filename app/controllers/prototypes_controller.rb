class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :create, :show, :update]
  before_action :move_to_index, except: [:index, :create, :show, :update,]
  def index
    @prototypes = Prototype.all
    #@prototypes = Prototype.includes(:user)
  end
 
  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
     if @prototype.save
      redirect_to root_path
       
     else
       render :new
     end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = Comment.all
  end

  def edit
    @prototype =Prototype.find(params[:id])
  end

  def update
     @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else 
      render :edit
    end
   
    #@prototype =update(prototype_params) 
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    render :index
  end



  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)

  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
end
end
