class Schedule < ApplicationRecord
    belongs_to :user
    belongs_to :status
    has_one :status_lock, dependent: :destroy
    has_one :status_detail, dependent: :destroy
end