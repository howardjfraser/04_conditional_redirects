class PeopleController < ApplicationController
  helper_method :form_redirect_url
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    @people = Person.all.sorted
  end

  def show
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new person_params
    if @person.save
      redirect_to @person, notice: "#{@person.name} has been created"
    else
      render :new
    end
  end

  def edit
    session[:start_point] = request.env['HTTP_REFERER']
  end

  def update
    if @person.update person_params
      redirect_to form_redirect_url, notice: "#{@person.name} has been updated"
    else
      render :edit
    end
  end

  def destroy
    @person.destroy
    redirect_to people_path, notice: "#{@person.name} has been deleted"
  end

  private

  def person_params
    params.require(:person).permit(:name, :job_title, :bio)
  end

  def set_person
    @person = Person.find params[:id]
  end

  def form_redirect_url
    session[:start_point] || @person
  end
end
