require './stack.rb'

def sort_stack!(stack)
  spare = Stack.new

  until stack.empty?
    el = stack.pop

    if spare.empty?
      spare.push(el)
    else
      until spare.empty? || spare.peek > el
        stack.push(spare.pop)
      end

      spare.push(el)
    end
  end

  until spare.empty?
    stack.push(spare.pop)
  end

  stack

end
