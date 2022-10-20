class Modification < ApplicationRecord
  belongs_to :period
  belongs_to :worker

  validates :period_id, :worker_id, presence: {code: "032"}
end
