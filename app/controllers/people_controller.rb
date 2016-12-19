class PeopleController < ApplicationController

  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :set_customers, only: :show
  before_action :set_relationships, only: :show

  # GET /people
  # GET /people.json
  def index
    @person_search_params = search_params
    @search = PersonSearch.new(@person_search_params)
    @people = @search.results.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /people/parents.json
  def parents
    q = params[:q]
    @people = if q.present?
      PersonSearch.new(keyword: q).results
    else
      Person.none
    end

    respond_to do |format|
      format.json
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    disable_editing!
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    @person.creator = current_user

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: t('.notice', person: @person) }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: t('.notice', person: @person) }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: t('.notice', person: @person) }
      format.json { head :no_content }
    end
  end

  protected
    def search_params
      params.fetch(:person_search) {{}}.permit(
        :keyword, :phone, :address, :postcode,
        :parental, :year_of_birth
      )
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    def set_customers
      @customers = @person.customers.at(current_unit)
      @other_customers = @person.customers - @customers
    end

    def set_relationships
      @relationships = @person.relationships
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(
        :identification, :date_of_birth, :last_name, :first_names,
        :gender, :email, :phone, :address, :postcode_id, :municipality_id,
        :language, :nationality, :accommodation, :disabilities,
        :education_level_id, :education_info
      )
    end
end
