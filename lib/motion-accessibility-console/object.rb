class NSObject

def browse(*args)
A11y::Console.browse(*args)
end
def view(*args)
A11y::Console.view(*args)
end
def touch(*args)
A11y::Console.touch(*args)
end

alias :b :browse
alias :v :view

end
