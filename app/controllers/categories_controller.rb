class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    @categories = current_user.categories
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = current_user.categories.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = current_user.categories.new(category_params)

    respond_to do |format|
      ActiveRecord::Base.transaction do
        if @category.save && StudyCategory.create(user_id: current_user.id, category_id: @category.id, is_archived: false).save
          # Create a category and lead to the detail page
          if params[:commit] == 'Create Category'
            format.html { redirect_to categories_url(), notice: "Category was successfully created." }
            format.json { render :show, status: :created, location: @category }
          else
            # Create a category and lead to create cards page
            puts @category.inspect
            format.html { redirect_to new_category_card_path(@category), notice: "Category was successfully created. Add cards." }
            format.json { render :show, status: :created, location: @category }
          end
        else
          # raise ActiveRecord::Rollback
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        if params[:commit] == 'Update Category'
          format.html { redirect_to category_url(@category), notice: "Category was successfully updated." }
          format.json { render :show, status: :ok, location: @category }
        else
          format.html { redirect_to category_cards_path(@category), notice: "Category was successfully updated. Add or update cards" }
          format.json { render :show, status: :ok, location: @category }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    study_category = StudyCategory.find_by(user_id: current_user.id, category_id: @category.id)
    ActiveRecord::Base.transaction do
      study_category.destroy!
      @category.destroy!
    end

    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = current_user.categories.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :description, :is_public)
    end
end
