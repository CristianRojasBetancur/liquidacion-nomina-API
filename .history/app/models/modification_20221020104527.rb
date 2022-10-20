class Modification < ApplicationRecord
  belongs_to period: {code: "0111"}
  belongs_to :worker

  validates :period_id, :worker_id, presence: {code: "032"}
end
