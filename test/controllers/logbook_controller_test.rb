require 'test_helper'

class LogbookControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get logbook_new_url
    assert_response :success
  end

  test "should get show" do
    get logbook_show_url
    assert_response :success
  end

  test "should get edit" do
    get logbook_edit_url
    assert_response :success
  end

  test "should get delete" do
    get logbook_delete_url
    assert_response :success
  end

end
