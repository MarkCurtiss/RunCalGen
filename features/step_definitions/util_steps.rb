Given /^it is '(\d{4}-\d{2}-\d{2})'$/ do |date|
  Timecop.freeze(Date.parse(date))
end


Then /^I should download a file called '(.*)'$/ do |filename|
  assert_match(/^text\/calendar/, page.response_headers['Content-Type'], 'The response was not a calendar file')
  assert_match(/^attachment; filename="#{filename}"/, page.response_headers['Content-Disposition'], 'The filenames did not match')
end

After do
  Timecop.return
end
