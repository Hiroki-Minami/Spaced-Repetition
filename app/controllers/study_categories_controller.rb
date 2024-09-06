class StudyCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_study_category, only: %i[ subscribe archive destroy ]
  # top page?
  # show all study categories in their repo
  def index
    @study_categories = current_user.study_categories
      .joins(:category)
      .left_joins(category: :cards)
      .select('study_categories.id, study_categories.is_archived, categories.id AS category_id, categories.name, categories.description, categories.is_public, ' \
              "CASE WHEN categories.user_id = #{current_user.id} THEN TRUE ELSE FALSE END AS is_owner, " \
              'COUNT(cards.id) AS card_count')
      .group('study_categories.id')

    if params[:filter].present?
      case params[:filter]
      when 'Not Archived' # this should be default
        @study_categories = @study_categories.where(is_archived: false)
      when 'Archived'
        @study_categories = @study_categories.where(is_archived: true)
      else
        # add 'All' to the filter
      end
    end


    if params[:q].present?
      q = "%#{params[:q]}%"
      # @categories = @categories.where("name LIKE ? OR description LIKE ?", q, q)
      @study_categories = @study_categories.where("categories.name LIKE ? OR categories.description LIKE ?", q, q)
    end
    # return categories that users don't subscribe to or don't own

    # puts @study_categories.inspect
  end

  # navigate to the study page
  def study
    @study_category = current_user.study_categories
        .select('study_categories.id, study_categories.is_archived, categories.id AS category_id, categories.name, categories.description, categories.is_public')
        .joins(:category)
        .find(params[:id])
    @study_cards = @study_category.study_cards
        .joins(:card)
        .select('study_cards.id, cards.instruction, cards.answer, cards.description, study_cards.understanding_level, study_cards.is_archived')
    # StudyCategory.find_by(user_id: current_user.id, category_id: @category.id)
    # retrieve cards associated with the category
    # retrieve study cards associated with the study category and cards
  end

  # insert a new study category with the user id and category id
  def subscribe
  end

  # update status of study categories
  # archive and so on
  def archive
    if @study_category.update(is_archived: true)
      redirect_to root_path, notice: "This category has been archived."
    else
      redirect_to root_path, notice: "Failed to archive this category.", status: :unprocessable_entity
    end
  end

  # delete or archive from the list
  def destroy
    if @study_category.destroy!
      redirect_to root_path, notice: "This category has been removed."
    else
      redirect_to root_path, notice: "Failed to remove this category.", status: :unprocessable_entity
    end
  end

  private
    # filter, search text
    def index_params
    end

    def set_study_category
      @study_category = current_user.study_categories.find(params[:id])
    end


end
