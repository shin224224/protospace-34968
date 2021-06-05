class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  #ログインしていない人がやれることがe
  before_action :set_prototype, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, except: [:index, :show]
  
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
   
    @comment = Comment.new
    @comments = Comment.all
  end

  def edit

  end

  def update
    
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else 
      render :edit
    end
   
    #@prototype =update(prototype_params) 
  end

  def destroy
   
    if @prototype.destroy
      redirect_to prototypes_path
    # render :index
    end
  end



  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)

  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    if @prototype.user !=  current_user
      redirect_to action: :index
    end
  end 
end
