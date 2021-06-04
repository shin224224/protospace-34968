class UsersController < ApplicationController
 def show
  @user = User.find(params[:id])
  @prototypes = @user.prototypes
end

#  user = User.find(params[:id])
#  @nickname = user.nickname
#  @tweets = user.tweets

 
  def user_params
    params.require(:user).permit(:name,:email, :profile, :occupation, :position)
  end
end
  