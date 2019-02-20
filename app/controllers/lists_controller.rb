class ListsController < ApplicationController
  before_action :find_list, only: [:edit, :update, :toggle, :destroy]

  def index
    @lists = List.includes(:list_items).all
  end

  def create
    @list = List.create(list_params)
  end

  def edit
  end

  def update
    @list.update(list_params)
  end

  def toggle
    @list.update(list_params)

    render 'destroy'
  end

  def destroy
    @list.destroy
  end

  private

  def find_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :publish)
  end
end
