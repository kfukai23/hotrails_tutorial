class Quote < ApplicationRecord
  belongs_to :company
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  # quote に紐づく company を渡し、独自の target_id を生成する。そうすることで、配信されるべきユーザにのみ turbo stream に配信されるようにする
  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend
end
