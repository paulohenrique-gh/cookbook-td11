require 'rails_helper'

feature 'Usuário vê as avaliações de uma receita' do
  scenario 'com sucesso' do
    # arrange
    recipe_author = create(:user)
    comment_author_a = create(:user)
    comment_author_b = create(:user)

    recipe = create(:recipe, user: recipe_author)
    recipe.ratings.create!(score: 4, comment: 'Muito bom', user: comment_author_a)
    recipe.ratings.create!(score: 1, comment: 'Péssimo', user: comment_author_b)

    # act
    visit recipe_path(recipe)

    # assert
    expect(page).to have_content 'user2@email.com'
    expect(page).to have_content 'Nota: 4'
    expect(page).to have_content 'Muito bom'

    expect(page).to have_content 'user3@email.com'
    expect(page).to have_content 'Nota: 1'
    expect(page).to have_content 'Péssimo'
  end

  scenario 'e não visualiza avaliações de outras receitas' do
    # arrange
    recipe_author_a = create(:user)
    recipe_author_b = create(:user)

    recipe_a = create(:recipe, user: recipe_author_a)
    recipe_b = create(:recipe, user: recipe_author_b)
    recipe_a.ratings.create!(score: 4, comment: 'Muito bom', user: recipe_author_b)
    recipe_b.ratings.create!(score: 1, comment: 'Péssimo', user: recipe_author_a)

    # act
    visit recipe_path(recipe_a)

    # assert
    expect(page).not_to have_content 'user2@email.com'
    expect(page).not_to have_content 'Nota: 1'
    expect(page).not_to have_content 'Péssimo'
  end

  scenario 'e visualiza a média das receitas' do
    # arrange
    recipe = create(:recipe, user: create(:user))

    create(:rating, recipe:, score: 3)
    create(:rating, recipe:, score: 5)
    create(:rating, recipe:, score: 3)

    # act
    visit recipe_path(recipe)

    # assert
    expect(page).to have_content 'Média de avaliações: 3,7'
  end

  scenario 'mas vê uma mensagem avisando que não existem avaliações' do
    # arrange
    recipe = create(:recipe, user: create(:user))

    # act
    visit recipe_path(recipe)

    # assert
    expect(page).not_to have_content 'Média de avaliações:'
    expect(page).to have_content 'Essa receita ainda não foi avaliada!'
  end
end
