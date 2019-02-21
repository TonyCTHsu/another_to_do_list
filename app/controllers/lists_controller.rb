class ListsController < ApplicationController
  before_action :status, only: [:index, :edit, :update, :toggle, :destroy]
  before_action :find_list, only: [:edit, :update, :toggle, :destroy]

  def index
    @lists = lists_scope.includes(:list_items).where(list_items: { publish: status } )
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

  def status
    @status ||= params.fetch(:status, 'true') == 'true'
  end

  def lists_scope
    List.publish_status(status)
  end

  def find_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :publish)
  end
end
