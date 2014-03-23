def full_title(page_title)
  base_title = "DevNation Bank"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_customer_in(customer)
	visit signin_path
	fill_in "Email",	with: customer.email
	fill_in "Password",	with: customer.password
	click_button "Sign in"
end