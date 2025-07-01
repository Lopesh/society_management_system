require "application_system_test_case"

class WingsTest < ApplicationSystemTestCase
  setup do
    @wing = wings(:one)
  end

  test "visiting the index" do
    visit wings_url
    assert_selector "h1", text: "Wings"
  end

  test "should create wing" do
    visit wings_url
    click_on "New wing"

    fill_in "Name", with: @wing.name
    click_on "Create Wing"

    assert_text "Wing was successfully created"
    click_on "Back"
  end

  test "should update Wing" do
    visit wing_url(@wing)
    click_on "Edit this wing", match: :first

    fill_in "Name", with: @wing.name
    click_on "Update Wing"

    assert_text "Wing was successfully updated"
    click_on "Back"
  end

  test "should destroy Wing" do
    visit wing_url(@wing)
    click_on "Destroy this wing", match: :first

    assert_text "Wing was successfully destroyed"
  end
end
