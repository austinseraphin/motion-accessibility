class NSObject

def browse(*args)
A11y::Browser.browse(*args)
end
def view(*args)
A11y::Browser.view(*args)
end
def touch(*args)
A11y::Browser.touch(*args)
end

alias :b :browse
alias :v :view

end
