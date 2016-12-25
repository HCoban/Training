require './queue_with_stacks.rb'

class AnimalShelter
  def initialize
    @cats = Queue.new
    @dogs = Queue.new
  end

  def dequeue_dog
    raise "No Dogs" unless @dogs.peek
    @dogs.dequeue
  end

  def dequeue_cat
    raise "No Cats" unless @cats.peek
    @cats.dequeue
  end

  def dequeue_any
    raise "No Animals" unless @dogs.peek || @cats.peek
    if @cats.peek.nil?
      dequeue_dog
    elsif @dogs.peek.nil?
      dequeue.cat
    elsif @cats.peek.time < @dogs.peek.time
      dequeue_cat
    else
      dequeue_dog
    end
  end

  def enqueue(animal)
    if animal.class == Cat
      @cats.enqueue(animal)
    else
      @dogs.enqueue(animal)
    end
  end
end

class Animal
  attr_reader :time

  def initialize
    @time = Time.now
  end
end

class Cat < Animal
end

class Dog < Animal
end
