class ListItem < ApplicationRecord
  belongs_to :list

  def toggle_button_name
    if publish?
      'Destroy'
    else
      'Restore'
    end
  end
end
