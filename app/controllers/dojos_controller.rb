class DojosController < ApplicationController
  def index
    @dojos = Dojo.all
  end

  def new

  end

  def create
    @dojo = Dojo.new(dojo_params)
    if @dojo.save
      redirect_to '/', notice:"You have added a Dojo!"
    else
      flash[:errors] = @dojo.errors.full_messages
      redirect_to '/new'
    end
  end

  def show
    @dojo = Dojo.find(params[:id])
    @students = @dojo.students
  end

  def edit
    @dojo = Dojo.find(params[:id])
  end

  def update
    @dojo = Dojo.find(params[:id])
    if @dojo.update(dojo_params)
      redirect_to '/', notice:"You have Updated a Dojo!"
    else
      flash[:errors] = @dojo.errors.full_messages
      redirect_to '/edit'
    end
  end

  def destroy
  Dojo.find(params[:id]).destroy
  redirect_to '/', notice:"You have Deleted a Dojo!"
  end

  private
    def dojo_params
      params.require(:dojo).permit(:branch, :street, :city, :state)
    end
end
