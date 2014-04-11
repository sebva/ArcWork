require 'test_helper'

class SolutionControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get create' do
    get :create
    assert_response :success
  end

  test 'should get comment' do
    get :comment
    assert_response :success
  end

end
