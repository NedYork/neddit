class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true
  validates :title, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :post_subs, dependent: :destroy

  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id
  )

end
