class MemberRequest < ApplicationRecord

  belongs_to :applicant, class_name: 'User', foreign_key: :appricant_id
  belongs_to :room
end
