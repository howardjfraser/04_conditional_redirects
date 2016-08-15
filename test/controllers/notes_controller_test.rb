require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  test 'get about' do
    get notes_about_url
    assert_response :success
    assert_select 'h1', 'Conditional Cancel'
  end
end
