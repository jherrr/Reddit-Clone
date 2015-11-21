class SubsController < ApplicationController

  before_action :require_user!
  before_action :require_moderator!, only: [:edit, :update, :destroy]

    def index
      render :index
    end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:error] = @sub.errors.full_messages
      render :new
    end
  end

  def update

  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  private

  def require_moderator!
    @sub = Sub.find(params[:id])
    redirect_to subs_url unless current_user.id == @sub.moderator_id
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
