class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category
  before_action :set_study_category, only: %i[ create destroy ]
  before_action :set_card, only: %i[ show edit update destroy ]

  def index
    @cards = @category.cards
  end

  def show
  end

  def new
    @card = @category.cards.new
  end

  def edit
  end

  def create
    @card = @category.cards.new(card_params)

    ActiveRecord::Base.transaction do
      if @card.save && StudyCard.create(card_id: @card.id, study_category_id: @study_category.id, understanding_level: 0, is_archived: false).save
        redirect_to category_cards_path(@category), notice: "Card was successfully created."
      else
        raise ActiveRecord::Rollback
        render :new, status: :unprocessable_entity
      end
    end
  end

  # update card
  # done on category page?
  def update
    if @card.update(card_params)
      redirect_to category_cards_path(@category), notice: "Card was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # remove cards from categories
  def destroy
    study_card = StudyCard.find_by(card_id: @card.id, study_category_id: @study_category.id)
    ActiveRecord::Base.transaction do
      if study_card.destroy! && @card.destroy!
        redirect_to category_cards_path(@category), notice: "Card was successfully destroyed."
      else
        raise ActiveRecord::Rollback
        render :index, status: :unprocessable_entity
      end
    end
  end

  private
    def card_params
      params.require(:card).permit(:answer, :instruction, :description)
    end

    def set_category
      @category = current_user.categories.find(params[:category_id])
    end

    def set_study_category
      @study_category = StudyCategory.find_by(user_id: current_user.id, category_id: params[:category_id])
    end

    def set_card
      @card = @category.cards.find(params[:id])
    end
end
