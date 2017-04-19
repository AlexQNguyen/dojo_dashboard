class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def new
    @dojos = Dojo.all
    @dojo = Dojo.find(params[:id])
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to "/show/#{params[:dojo_id]}", notice:"You have added a Student!"
    else
      flash[:errors] = @student.errors.full_messages
      redirect_to '/'
    end
  end

  def show

    @student = Student.find(params[:id])
    @dojo = Dojo.find(params[:dojo_id])
    @cohort = Student.where(dojo_id: params[:dojo_id]).where.not(id: params[:id])
  end

  def edit
    @dojos = Dojo.all
    @student = Student.find(params[:id])
  end

  def update
    @students = Student.find(params[:id])
    if @students.update(student_params)
      redirect_to "/show/#{@students.dojo_id}", notice:"You have Updated a Dojo!"
    else
      flash[:errors] = @dojo.errors.full_messages
      redirect_to '/edit'
    end
  end

  def destroy

    Student.find(params[:id]).destroy
    redirect_to :back
  end

  private
    def student_params
      params.require(:student).permit(:first_name, :last_name, :email, :dojo_id)
    end
end
