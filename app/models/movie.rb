class Movie < ApplicationRecord
  mount_uploader :poster, PosterUploader

  has_many :reviews

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_past

  scope :title_search, ->(title) { where("title like ?", title) }
  scope :director_search, ->(director) { where("director like ?", director) }
  scope :duration_search, ->(a=nil, b=nil) { 
    if b.nil?
      where("runtime_in_minutes > ?", a)
    elsif a.nil?
      where("runtime_in_minutes < ?", b)
    else
      where("runtime_in_minutes >= ? AND runtime_in_minutes <= ?", a, b)
    end
  }

  def review_average
    return 0 if reviews.count == 0
      reviews.sum(:rating_out_of_ten)/reviews.count
  end


  protected
  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "Should be in the past") if release_date > Date.today
    end
  end
    
end
