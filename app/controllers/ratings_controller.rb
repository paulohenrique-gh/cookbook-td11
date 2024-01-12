class RatingsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @rating = @recipe.ratings.build(ratings_params)
    @rating.user = current_user

    if @rating.save
      redirect_to @recipe, notice: 'Comentário enviado com sucesso!'
    else
      session[:rating] = @rating
      redirect_to @recipe, notice: 'Não foi possível registrar o comentário'
    end
  end

  private

  def ratings_params
    params.require(:rating).permit(:score, :comment)
  end
end
