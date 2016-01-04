class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validates :subs, length: { minimum: 1 }

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id
  )

  has_many :comments
  has_many :subs, through: :post_subs
  has_many :post_subs, dependent: :destroy

  def top_level_comments
    self.comments.where(parent_comment_id: nil)
  end

end
