class ListItemsController < ApplicationController
  before_action :find_list, only: [:create, :edit, :update, :toggle, :destroy]
  before_action :find_list_item, only: [:edit, :update, :toggle, :destroy]

  def create
    @list_item = @list.list_items.create(list_item_params)
  end

  def edit
  end

  def update
    @list_item.update(list_item_params)
  end

  def toggle
    @list_item.update(list_item_params)

    render 'destroy'
  end

  def destroy
    @list_item.destroy
  end

  private

  def find_list
    @list = List.find(params[:list_id])
  end

  def find_list_item
    @list_item = @list.list_items.find(params[:id])
  end

  def list_item_params
    params.require(:list_item).permit(:description, :publish)
  end
end
