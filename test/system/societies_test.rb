require "application_system_test_case"

class SocietiesTest < ApplicationSystemTestCase
  setup do
    @society = societies(:one)
  end

  test "visiting the index" do
    visit societies_url
    assert_selector "h1", text: "Societies"
  end

  test "should create society" do
    visit societies_url
    click_on "New society"

    fill_in "Address", with: @society.address
    fill_in "Contact email", with: @society.contact_email
    fill_in "Name", with: @society.name
    fill_in "Phone", with: @society.phone
    fill_in "Subdomain", with: @society.subdomain
    click_on "Create Society"

    assert_text "Society was successfully created"
    click_on "Back"
  end

  test "should update Society" do
    visit society_url(@society)
    click_on "Edit this society", match: :first

    fill_in "Address", with: @society.address
    fill_in "Contact email", with: @society.contact_email
    fill_in "Name", with: @society.name
    fill_in "Phone", with: @society.phone
    fill_in "Subdomain", with: @society.subdomain
    click_on "Update Society"

    assert_text "Society was successfully updated"
    click_on "Back"
  end

  test "should destroy Society" do
    visit society_url(@society)
    click_on "Destroy this society", match: :first

    assert_text "Society was successfully destroyed"
  end
end
