class StudyCategoriesController < ApplicationController
  before_action :authenticate_user!
  # top page?
  # show all study categories in their repo
  def index
    # TODO: filter variable
    # TODO: query
    # get study categories
  end

  # choose one study category
  def show
    # TODO get a study category and cards
    # retrieve a study category and related study cards
  end

  # might not be called
  # download? public categories
  def create
  end

  # might not be called
  # update status of study categories
  # archive and so on
  # show page
  def edit
  end

  # update status of study categories
  # archive and so on
  def update
  end

  # delete or archive from the list
  def destroy
  end

  private
    # filter, search text
    def index_params
    end


end
