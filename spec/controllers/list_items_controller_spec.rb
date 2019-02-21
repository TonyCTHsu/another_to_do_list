require 'rails_helper'

describe ListItemsController do
  describe '#create' do
    it do
      list = FactoryBot.create(:list)

      expect do
        post :create, params: { list_id: list.id, list_item: { description: 'what', publish: true } }, xhr: true
      end.to change { list.list_items.reload.size }.by(1)

      expect(response).to be_successful
      expect(response).to render_template('create')
    end
  end

  describe '#edit' do
    it do
      list, item = create_list_with_list_item(true, true)

      get :edit, params: { list_id: list.id, id: item.id }, xhr: true

      expect(response).to be_successful
      expect(response).to render_template('edit')
      expect(assigns(:list)).to eq(list)
      expect(assigns(:list_item)).to eq(item)
    end
  end

  describe '#update' do
    it do
      list, item = create_list_with_list_item(true, true)

      expect do
        post :update,
          params: {
            list_id: list.id,
            id: item.id,
            list_item: { description: 'what' }
          }, xhr: true
      end.to change { item.reload.description }.to('what')

      expect(response).to be_successful
      expect(response).to render_template('update')
      expect(assigns(:list)).to eq(list)
      expect(assigns(:list_item)).to eq(item)
    end
  end

  describe '#toggle' do
    it do
      list, item = create_list_with_list_item(true, true)

      expect do
        post :toggle,
          params: {
            list_id: list.id,
            id: item.id,
            list_item: { publish: false }
          }, xhr: true
      end.to change { item.reload.publish }.from(true).to(false)

      expect(list.reload.publish).to eq(true)

      expect(response).to be_successful
      expect(response).to render_template('destroy')
      expect(assigns(:list)).to eq(list)
      expect(assigns(:list_item)).to eq(item)
    end

    it do
      list, item = create_list_with_list_item(false, false)

      expect do
        post :toggle,
          params: {
            list_id: list.id,
            id: item.id,
            list_item: { publish: true }
          }, xhr: true
      end.to change { item.reload.publish }.from(false).to(true)

      expect(response).to be_successful
      expect(response).to render_template('destroy')
      expect(assigns(:list)).to eq(list)
      expect(assigns(:list_item)).to eq(item)
    end
  end

  describe '#destroy' do
    it do
      list, item = create_list_with_list_item(true, true)

      expect do
        delete :destroy, params: { list_id: list.id, id: item.id }, xhr: true
      end.to change { ListItem.exists?(item.id) }.from(true).to(false)

      expect(List.exists?(list.id)).to eq(true)
      expect(response).to be_successful
      expect(response).to render_template('destroy')
    end
  end

  def create_list_with_list_item(list_status, item_status)
    list = FactoryBot.create(:list, publish: list_status)
    item = FactoryBot.create(:list_item, publish: item_status, list: list)

    [list, item]
  end
end
