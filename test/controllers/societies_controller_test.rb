require "test_helper"

class SocietiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @society = societies(:one)
  end

  test "should get index" do
    get societies_url
    assert_response :success
  end

  test "should get new" do
    get new_society_url
    assert_response :success
  end

  test "should create society" do
    assert_difference("Society.count") do
      post societies_url, params: { society: { address: @society.address, contact_email: @society.contact_email, name: @society.name, phone: @society.phone, subdomain: @society.subdomain } }
    end

    assert_redirected_to society_url(Society.last)
  end

  test "should show society" do
    get society_url(@society)
    assert_response :success
  end

  test "should get edit" do
    get edit_society_url(@society)
    assert_response :success
  end

  test "should update society" do
    patch society_url(@society), params: { society: { address: @society.address, contact_email: @society.contact_email, name: @society.name, phone: @society.phone, subdomain: @society.subdomain } }
    assert_redirected_to society_url(@society)
  end

  test "should destroy society" do
    assert_difference("Society.count", -1) do
      delete society_url(@society)
    end

    assert_redirected_to societies_url
  end
end
