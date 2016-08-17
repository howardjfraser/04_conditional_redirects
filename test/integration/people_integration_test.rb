require 'test_helper'

class PeopleIntegrationTest < ActionDispatch::IntegrationTest
  test 'add person' do
    new_name = sample_string
    new_job_title = sample_string
    new_bio = sample_string

    visit '/people'
    assert page.has_content? 'People'
    click_on 'Add New'
    assert page.has_content? 'New'
    fill_in('Name', with: new_name)
    fill_in('Job title', with: new_job_title)
    fill_in('Bio', with: new_bio)
    click_on 'Save'
    assert page.has_content? new_name
    assert page.has_content? new_name
    assert page.has_content? new_job_title
    assert page.has_content? new_bio
    click_on 'People'
    assert page.has_content? new_name
  end

  test 'edit person' do
    new_name = sample_string
    new_job_title = sample_string
    new_bio = sample_string

    visit '/people'
    first('li a').click
    assert page.has_content? 'Job Title'
    click_on 'Edit'
    fill_in('Name', with: new_name)
    fill_in('Job title', with: new_job_title)
    fill_in('Bio', with: new_bio)
    click_on 'Save'
    assert page.has_content? new_name
    assert page.has_content? new_job_title
    assert page.has_content? new_bio
    assert page.has_content? "#{new_name} has been updated"
  end

  test 'cancel and save redirect to start point' do
    check_redirect 'Cancel'
    check_redirect 'Save'
  end

  private

  def check_redirect(action)
    check_person action
    check_people action
  end

  def check_person(action)
    visit '/people'
    first('li').click_on('view')
    click_on 'Edit'
    click_on action
    assert find('//h1').text == 'David Jones'
  end

  def check_people(action)
    visit '/people'
    first('li').click_on('edit')
    click_on action
    assert find('//h1').text == 'People'
  end
end
