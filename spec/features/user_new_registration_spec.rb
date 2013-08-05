require 'spec_helper'

feature 'User does new registration', { js: true, vcr: true } do

  scenario 'with valid personal and credit card info' do
    new_user_registration("johndoe@example.com", "4242424242424242")

    expect(page).to have_content "Sign in"

    new_user_sign_in("johndoe@example.com")
    expect(page).to have_content "Welcome"
  end

  scenario 'with valid personal info and invalid credit card info' do
    new_user_registration("johndoe@example.com", "12345")

    expect(page).to have_content("This card number looks invalid")

    new_user_sign_in("johndoe@example.com")
    expect(page).to have_content("Invalid email or password.")
  end

  scenario 'with valid personal info but declined credit card' do
    new_user_registration("johndoe@example.com", "4000000000000002")

    expect(page).to have_content("Your card was declined.")

    new_user_sign_in("johndoe@example.com")
    expect(page).to have_content("Invalid email or password.")
  end

  scenario 'with invalid personal info and valid credit card info' do
    new_user_registration("", "4000000000000002")

    expect(page).to have_content("can't be blank")

    new_user_sign_in("johndoe@example.com")
    expect(page).to have_content("Invalid email or password.")
  end

  scenario 'with invalid personal info and invalid credit card info' do
    new_user_registration("", "12345")

    expect(page).to have_content("This card number looks invalid")

    new_user_sign_in("johndoe@example.com")
    expect(page).to have_content("Invalid email or password.")
  end

  scenario 'with invalid personal info and declined credit card' do
    new_user_registration("", "4000000000000002")

    expect(page).to have_content("can't be blank")

    new_user_sign_in("johndoe@example.com")
    expect(page).to have_content("Invalid email or password.")
  end

  def new_user_registration(email, credit_card)
    visit root_path
    click_link "Sign Up Now!"
    fill_in "Email Address", with: email
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "John Doe"
    fill_in "Credit Card Number", with: credit_card
    fill_in "Security Code", with: "123"
    select  "7 - July", from: "date_month"
    select  "2015", from: "date_year"
    click_button "Sign Up"
  end

  def new_user_sign_in(email)
    visit sign_in_path
    fill_in "Email", with: email
    fill_in "Password", with: "password"
    click_button "Sign in"
  end
end