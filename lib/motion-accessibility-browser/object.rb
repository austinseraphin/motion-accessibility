class NSObject

def browse(*args)
A11y::Browser.browse(*args)
end
def view(*args)
A11y::Browser.view(*args)
end

alias :b :browse
alias :v :view

end
