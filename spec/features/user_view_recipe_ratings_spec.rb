require 'rails_helper'

feature 'Usuário vê as avaliações de uma receita' do
  scenario 'com sucesso' do
    # arrange
    recipe_author = create(:user)
    comment_author_a = create(:user)
    comment_author_b = create(:user)

    recipe = create(:recipe, user: recipe_author)
    rating_a = recipe.ratings.create!(score: 4, comment: 'Muito bom', user: comment_author_a)
    rating_b = recipe.ratings.create!(score: 1, comment: 'Péssimo', user: comment_author_b)

    # act
    visit recipe_path(recipe)

    # assert
    expect(page).to have_content 'user1@email.com'
    expect(page).to have_content 'Nota: 4'
    expect(page).to have_content 'Muito bom'

    expect(page).to have_content 'user2@email.com'
    expect(page).to have_content 'Nota: 1'
    expect(page).to have_content 'Péssimo'
  end
end
