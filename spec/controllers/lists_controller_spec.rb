require 'rails_helper'

describe ListsController do
  describe '#index' do
    context 'when no parameters' do
      it do
        published_list, _ = create_list_with_list_item(true, true)
        unpublished_list, _ = create_list_with_list_item(false, false)

        get :index

        expect(response).to be_successful
        expect(response).to render_template('index')
        expect(assigns(:lists)).to contain_exactly(published_list)
        expect(assigns(:status)).to eq(true)
      end
    end

    context 'when status true' do
      it do
        published_list, _ = create_list_with_list_item(true, true)
        unpublished_list, _ = create_list_with_list_item(false, false)

        get :index, params: { status: true }

        expect(response).to be_successful
        expect(response).to render_template('index')
        expect(assigns(:lists)).to contain_exactly(published_list)
        expect(assigns(:status)).to eq(true)
      end
    end

    context 'when status false' do
      it do
        published_list, _ = create_list_with_list_item(true, true)
        unpublished_list, _ = create_list_with_list_item(false, false)

        get :index, params: { status: false }

        expect(response).to be_successful
        expect(response).to render_template('index')
        expect(assigns(:lists)).to contain_exactly(unpublished_list)
        expect(assigns(:status)).to eq(false)
      end
    end
  end

  describe '#create' do
    it do
      expect do
        post :create, params: { list: { name: 'what', publish: true } }, xhr: true
      end.to change { List.count }.by(1)

      expect(response).to be_successful
      expect(response).to render_template('create')
    end
  end

  describe '#edit' do
    it do
      published_list = FactoryBot.create(:list)

      get :edit, params: { id: published_list.id }, xhr: true

      expect(response).to be_successful
      expect(response).to render_template('edit')
      expect(assigns(:list)).to eq(published_list)
    end
  end

  describe '#update' do
    it do
      published_list = FactoryBot.create(:list)

      expect do
        post :update, params: { id: published_list.id, list: { name: 'what' } }, xhr: true
      end.to change { published_list.reload.name }.to('what')

      expect(response).to be_successful
      expect(response).to render_template('update')
      expect(assigns(:list)).to eq(published_list)
    end
  end

  describe '#toggle' do
    it do
      list, item = create_list_with_list_item(true, true)

      expect do
        post :toggle, params: { id: list.id, list: { publish: false } }, xhr: true
        list.reload
        item.reload
      end.to change { list.publish }.from(true).to(false).
        and change { item.publish }.from(true).to(false)

      expect(response).to be_successful
      expect(response).to render_template('destroy')
      expect(assigns(:list)).to eq(list)
    end

    it do
      list, item = create_list_with_list_item(false, false)

      expect do
        post :toggle, params: { id: list.id, list: { publish: true } }, xhr: true
        list.reload
        item.reload
      end.to change { list.publish }.from(false).to(true).
        and change { item.publish }.from(false).to(true)

      expect(response).to be_successful
      expect(response).to render_template('destroy')
      expect(assigns(:list)).to eq(list)
    end
  end

  describe '#destroy' do
    it do
      list, _ = create_list_with_list_item(true, true)

      expect do
        delete :destroy, params: { id: list.id }, xhr: true
      end.to change { List.count }.from(1).to(0).
        and change { ListItem.count }.from(1).to(0)

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
