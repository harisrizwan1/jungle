require 'rails_helper'

RSpec.feature 'Visitor navigates to product using link', type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name: Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end

  scenario 'They can navigate from the home page to product details' do
    visit root_path

    link = find('article.product header a')
    link.click
    
    # save_screenshot

    expect(page).to have_css 'article.product-detail'

  end
end