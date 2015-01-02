require 'test_helper'

class BitcoinAccountsControllerTest < ActionController::TestCase
  setup do
    @bitcoin_account = bitcoin_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bitcoin_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bitcoin_account" do
    assert_difference('BitcoinAccount.count') do
      post :create, bitcoin_account: {  }
    end

    assert_redirected_to bitcoin_account_path(assigns(:bitcoin_account))
  end

  test "should show bitcoin_account" do
    get :show, id: @bitcoin_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bitcoin_account
    assert_response :success
  end

  test "should update bitcoin_account" do
    patch :update, id: @bitcoin_account, bitcoin_account: {  }
    assert_redirected_to bitcoin_account_path(assigns(:bitcoin_account))
  end

  test "should destroy bitcoin_account" do
    assert_difference('BitcoinAccount.count', -1) do
      delete :destroy, id: @bitcoin_account
    end

    assert_redirected_to bitcoin_accounts_path
  end
end
