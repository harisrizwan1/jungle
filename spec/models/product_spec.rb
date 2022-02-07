require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      @category = Category.new
      @product = Product.new(name: 'Test Item 3000', price: 350, quantity: 24, category: @category)
    end

    it "saves all fields" do
      expect(@product.errors.full_messages).to be_empty
    end
    it "errors if name is missing" do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it "errors if price is missing" do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it "errors if quantity is missing" do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "errors if category is missing" do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end