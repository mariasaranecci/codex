class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
	def released_1930_or_later
    errors.add(:release_date, 'must be 1930 or later') if
        release_date && release_date < Date.parse('1 Jan 1930')
end

@@grandfathered_date = Date.parse('1 Nov 1968')

def grandfathered?
  release_date && release_date < @@grandfathered_date
end
  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

    def avg_reviews
      sum = 0
      self.reviews.each do |review|
        sum = sum + review.potatoes
      end
      if self.reviews.count>0
        return sum/self.reviews.count
      else
        return "--"
      end
    end
end