module RatingHelper
  def average_score(recipe)
    number_with_precision(recipe.ratings.average(:score), precision: 1)
  end
end
