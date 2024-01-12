require 'rails_helper'

feature 'Usuário registra avaliação em uma receita' do
  scenario 'e precisa estar autenticado' do
    # arrange
    recipe = create(:recipe)

    # act
    visit recipe_path(recipe)

    # assert
    expect(page).to have_content 'Faça login para comentar'
    expect(page).not_to have_css '#comment-form'
  end

  scenario 'com sucesso' do
    # arrange
    recipe = create(:recipe)
    user = create(:user, email: 'billy@email.com')

    # act
    login_as user
    visit recipe_path(recipe)

    fill_in 'Comentário', with: 'Muito bom'
    select '1', from: 'Nota'
    click_on 'Comentar'

    # assert
    expect(page).to have_content 'Comentário enviado com sucesso!'
    expect(page).to have_content 'billy@email.com'
    expect(page).to have_content 'Nota: 1'
    expect(page).to have_content 'Muito bom'
  end

  scenario 'e não registra nota' do
    # arrange
    recipe = create(:recipe)
    user = create(:user)

    # act
    login_as user
    visit recipe_path(recipe)

    select 'Selecione uma nota', from: 'Nota'
    fill_in 'Comentário', with: 'Bacana'
    click_on 'Comentar'

    # assert
    expect(recipe.reload.ratings.count).to eq 0
    expect(page).to have_content 'Não foi possível registrar o comentário'
    expect(page).to have_content 'Nota não pode ficar em branco'
  end
end
