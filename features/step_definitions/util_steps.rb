Given /^it is '(\d{4}-\d{2}-\d{2})'$/ do |date|
  Timecop.freeze(Date.parse(date))
end


Then /^I should download a file called '(.*)'$/ do |filename|
  assert_match(/^attachment;/, page.response_headers['Content-Disposition'], "The response was not an attachment.")
  assert_match(/^text\/calendar(?:$|;)/, page.response_headers['Content-Type'])
end
