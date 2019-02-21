class List < ApplicationRecord
  has_many :list_items, dependent: :destroy

  before_save :cascade_update_items, if: :publish_changed?

  scope :publish_status, -> (status) do
    where(publish: status)
  end


  def toggle_button_name
    if publish?
      'Destroy'
    else
      'Restore'
    end
  end

  private

  def cascade_update_items
    list_items.where(publish: !publish).update_all(publish: publish)
  end
end
